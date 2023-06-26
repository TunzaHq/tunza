import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:tunza/util/globals.dart';

class Requests with Glob {
  Future<Map<String, dynamic>?> getUserClaim(int claimId) async {
    final res = await http
        .get(Uri.parse(baseUrl + user + '/claims/$claimId'), headers: {
      "authorization": "Bearer ${prefs?.getString('token')}",
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    });
    if (res.statusCode != 200) return null;
    return Map<String, dynamic>.from(json.decode(res.body));
  }

  Future<bool> createClaim(
      int coverId, int subId, Map<int?, String?> data) async {
    final position = await _determinePosition();
    // Create Claim
    final res = await http.post(Uri.parse(baseUrl + claims),
        headers: {
          "authorization": "Bearer ${prefs?.getString('token')}",
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "location": "${position.latitude},${position.longitude}",
          "subscription_id": subId,
          "description": "USER INITIATED CLAIM",
          "plan_id": coverId
        }));

    if (res.statusCode != 201) return false;
    final claimId = json.decode(res.body)['id'];

    var answers = [];

    for (var i = 0; i < data.length; i++) {
      answers.add({
        "question_id": data.keys.elementAt(i),
        "answer": data.values.elementAt(i)
      });
    }

    final response =
        await http.post(Uri.parse(baseUrl + claims + '/$claimId/answer'),
            headers: {
              "authorization": "Bearer ${prefs?.getString('token')}",
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            },
            body: jsonEncode({
              "answers": answers,
            }));

    return response.statusCode == 201;
  }

  Future<List<Map<String, dynamic>>?> getAllCovers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + covers), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      });
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>?> getCoverById(int id) async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + covers + '/$id'), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "authorization": "Bearer ${prefs?.getString('token')}"
      });
      return Map<String, dynamic>.from(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUsersCoverById(int id) async {
    try {
      print(id);
      final response =
          await http.get(Uri.parse(baseUrl + user + '/covers/$id'), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "authorization": "Bearer ${prefs?.getString('token')}"
      });
      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(json.decode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getUserCovers([String? status]) async {
    try {
      final response = await http.get(
          Uri.parse(baseUrl +
              user +
              '/covers${status != null ? '?status=${status.toUpperCase()}' : ''}'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            "authorization": "Bearer ${prefs?.getString('token')}"
          });
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    final response = await http.get(Uri.parse(baseUrl + user), headers: {
      "authorization": "Bearer ${prefs?.getString('token')}",
    });

    if (response.statusCode == 200) {
      return userDetail = Map<String, dynamic>.from(json.decode(response.body));
    }
    return null;
  }

  Future<String?> uploadFile(File file, String type) async {
    final cloud = await cloudinary.upload(
      file: file.path,
      fileBytes: file.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      fileName: file.path.split('/').last.split('.').first +
          '${DateTime.now().millisecondsSinceEpoch}',
    );

    await http.post(Uri.parse(baseUrl + media),
        body: jsonEncode({
          "type": type,
          "url": cloud.secureUrl,
          "file_name": cloud.originalFilename,
        }),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "authorization": "Bearer ${prefs?.getString('token')}"
        }).catchError((e) {
      print(e);
    });

    return cloud.secureUrl;
  }

  Future<List<Map<String, dynamic>>?> getClaims() async {
    final response =
        await http.get(Uri.parse(baseUrl + user + '/claims'), headers: {
      "authorization": "Bearer ${prefs?.getString('token')}",
    }).catchError((e) {
      print(e);
    });

    return List<Map<String, dynamic>>.from(json.decode(response.body) ?? '[]');
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  FutureOr<void> updateUserLocation([String? pos]) async {
    final position = await _determinePosition();
    await http.patch(Uri.parse(baseUrl + user),
        body: jsonEncode(
          {"location": "${position.latitude},${position.longitude}"},
        ),
        headers: {
          "authorization": "Bearer ${prefs?.getString('token')}",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }).catchError((e) {
      print(e);
    });
  }

  Future<Map<String, dynamic>?> getMediaById(int id) async {
    final response =
        await http.get(Uri.parse(baseUrl + media + '/$id'), headers: {
      "authorization": "Bearer ${prefs?.getString('token')}",
      "Accept": "application/json",
      "Content-Type": "application/json",
    }).catchError((e) {
      print(e);
    });

    return Map<String, dynamic>.from(json.decode(response.body));
  }

  Future<List<Map<String, dynamic>>?> getMedia() async {
    final response =
        await http.get(Uri.parse(baseUrl + user + '/media'), headers: {
      "authorization": "Bearer ${prefs?.getString('token')}",
      "Accept": "application/json",
      "Content-Type": "application/json",
    }).catchError((e) {
      print(e);
    });

    return List<Map<String, dynamic>>.from(json.decode(response.body));
  }

  Future<bool> subscribe(int coverId) async {
    final response = await http.post(Uri.parse(baseUrl + subscriptions),
        body: jsonEncode({"plan_id": coverId}),
        headers: {
          "authorization": "Bearer ${prefs?.getString('token')}",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }).catchError((e) {
      print(e);
    });

    return response.statusCode == 200;
  }

  Future<List<Map<String, dynamic>>?> getQuestions(int coverId) async {
    final response = await http
        .get(Uri.parse(baseUrl + covers + '/$coverId/questions'), headers: {
      "authorization": "Bearer ${prefs?.getString('token')}",
      "Accept": "application/json",
      "Content-Type": "application/json",
    }).catchError((e) {
      print(e);
    });

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    return null;
  }
}
