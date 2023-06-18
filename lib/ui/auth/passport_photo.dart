import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tunza/data/requests.dart';
import 'package:tunza/ui/auth/identification.dart';
import 'package:tunza/ui/widgets/widgets.dart';
import 'package:tunza/util/globals.dart';
import 'package:tunza/util/file_path.dart';
import 'package:http/http.dart' as http;

class PassportPhoto extends StatefulWidget {
  const PassportPhoto({super.key});

  @override
  State<PassportPhoto> createState() => _PassportPhotoState();
}

class _PassportPhotoState extends State<PassportPhoto>
    with WidgetsBindingObserver, Glob {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<CameraController> _getCamera() async {
    bool cameraPermission = await Permission.camera.isGranted;
    if (!cameraPermission) {
      await Permission.camera.request();
    }

    final cameras = await availableCameras();

    final camera = cameras.firstWhere(
      (element) => element.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(camera, ResolutionPreset.veryHigh);
    await _controller.initialize();
    return _controller;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _controller = CameraController(
          cameraController.description, ResolutionPreset.veryHigh);
    }
  }

  XFile? file;

  bool uploading = false;

  final requests = Requests();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            RotatedBox(
              quarterTurns: 2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: SvgPicture.asset(
                    mainBanner,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () async => await exitMessenger(context,
                        "Are you sure you want to exit? A complete profile is required to use the app"),
                    icon: const Icon(Icons.arrow_back))),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(logo),
            ),
            const Text(
              'Tunza',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Passport Photo',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            file != null
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey)),
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.file(
                        File(file!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey)),
                    child: FutureBuilder<CameraController>(
                        future: _getCamera(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            _controller = snapshot.data!;
                            return SizedBox(
                              width: 200,
                              height: 200,
                              child: AspectRatio(
                                aspectRatio: 2,
                                child: CameraPreview(
                                  _controller,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent),
                                  ),
                                ),
                              ),
                            );
                          }
                          return const CircularProgressIndicator.adaptive(
                              strokeWidth: 1,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              backgroundColor: Color(0xFFFFAC30));
                        }),
                  ),
            const SizedBox(
              height: 40,
            ),
            file != null && !uploading
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        elevation: 0,
                        color: const Color(0xFFFFAC30),
                        height: 50,
                        minWidth: 200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () async {
                          setState(() {
                            uploading = true;
                          });

                          final url = await requests.uploadFile(
                              File(file!.path), "PASSPORT");

                          final res =
                              await http.patch(Uri.parse(baseUrl + user),
                                  body: jsonEncode({
                                    "avatar": url,
                                  }),
                                  headers: {
                                "Accept": "application/json",
                                "Content-Type": "application/json",
                                "authorization":
                                    "Bearer ${prefs?.getString('token')}"
                              });

                          if (res.statusCode == 200) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Identification()));
                          }
                          messenger(context, "Error uploading photo");

                          setState(() {
                            uploading = false;
                          });
                        },
                        child: Text(
                          'Next',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  )
                : uploading
                    ? const CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: Color(0xFFFFAC30))
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            elevation: 0,
                            color: const Color(0xFFFFAC30),
                            height: 50,
                            minWidth: 200,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            onPressed: () async {
                              file = await _controller.takePicture();
                              setState(() {});
                            },
                            child: Text(
                              'Take Photo',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                      ),
          ]),
        ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }
}
