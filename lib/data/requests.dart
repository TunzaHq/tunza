import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunza/util/globals.dart';

class Requests with Glob {
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
        "authorization": "Bearer ${prefs.getString('token')}"
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
        "authorization": "Bearer ${prefs.getString('token')}"
      });
      print(response.body);
      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(json.decode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getUserCovers() async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + user + '/covers'), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "authorization": "Bearer ${prefs.getString('token')}"
      });
      print(response.body);
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    try {
      if (userDetail.isNotEmpty) {
        return userDetail;
      }
      final response = await http.get(Uri.parse(baseUrl + user), headers: {
        "authorization": "Bearer ${prefs?.getString('token')}",
      });

      print(response.body);

      if (response.statusCode == 200) {
        return userDetail =
            Map<String, dynamic>.from(json.decode(response.body));
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> uploadFile(File file, String type) async {
    final cloud = await cloudinary
        .upload(
      file: file.path,
      fileBytes: file.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      fileName: file.path.split('/').last.split('.').first +
          '${DateTime.now().millisecondsSinceEpoch}',
    )
        .catchError((e) {
      print(e);
    });

    await http.post(Uri.parse(baseUrl + media),
        body: jsonEncode({
          "type": type,
          "url": cloud.secureUrl,
          "file_name": cloud.originalFilename,
        }),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "authorization": "Bearer ${prefs.getString('token')}"
        }).catchError((e) {
      print(e);
    });

    return cloud.secureUrl;
  }

  Future<List<Map<String, dynamic>>?> getClaims() async {
    final response =
        await http.get(Uri.parse(baseUrl + user + '/claims'), headers: {
      "authorization": "Bearer ${prefs.getString('token')}",
    }).catchError((e) {
      print(e);
    });

    return List<Map<String, dynamic>>.from(json.decode(response.body) ?? '[]');
  }
}
