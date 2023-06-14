import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunza/ui/auth/success.dart';
import 'package:tunza/util/file_path.dart';

class Identification extends StatefulWidget {
  const Identification({super.key});

  @override
  State<Identification> createState() => _IdentificationState();
}

class _IdentificationState extends State<Identification> {
  XFile? frontFile;
  XFile? backFile;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              const SizedBox(
                height: 80,
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
                'Identification Documents',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Front Side',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 150,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: frontFile == null
                    ? GestureDetector(
                        onTap: () async => await ImagePicker()
                            .pickImage(source: ImageSource.camera)
                            .then((value) => setState(() {
                                  frontFile = value;
                                })),
                        child: const Icon(
                          Icons.add_a_photo,
                          size: 32,
                          color: Color(0xff707070),
                        ),
                      )
                    : Image.file(
                        File(frontFile!.path),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Back Side',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 150,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: backFile == null
                    ? GestureDetector(
                        onTap: () async => await ImagePicker()
                            .pickImage(source: ImageSource.camera)
                            .then((value) => setState(() {
                                  backFile = value;
                                })),
                        child: const Icon(
                          Icons.add_a_photo,
                          size: 32,
                          color: Color(0xff707070),
                        ),
                      )
                    : Image.file(File(backFile!.path),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
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
                      await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const Success()));
                    },
                    child: Text(
                      'Next',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                child: RotatedBox(
                  quarterTurns: 1,
                  child: SvgPicture.asset(
                    mainBanner,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
