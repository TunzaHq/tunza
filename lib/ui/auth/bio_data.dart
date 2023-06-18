import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunza/data/requests.dart';
import 'package:tunza/ui/auth/identification.dart';
import 'package:tunza/ui/auth/passport_photo.dart';
import 'package:tunza/ui/widgets/widgets.dart';
import 'package:tunza/util/globals.dart';
import 'package:tunza/util/file_path.dart';
import 'package:http/http.dart' as http;

class BioData extends StatefulWidget {
  const BioData({super.key});

  @override
  State<BioData> createState() => _BioDataState();
}

class _BioDataState extends State<BioData> with WidgetsBindingObserver, Glob {
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  bool isLoading = false;

  final requests = Requests();

  Future<void> updateProfile() async {
    try {
      if (!(_bio.currentState?.validate() ?? false)) {
        return;
      }

      setState(() {
        isLoading = true;
      });

      final response = await http.patch(Uri.parse(baseUrl + user),
          body: jsonEncode({
            "dob": dobController.text.trim(),
            "gender": genderController.text.trim().toUpperCase(),
            "occupation": occupationController.text.trim()
          }),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "authorization": "Bearer ${prefs?.getString('token')}"
          });

      if (response.statusCode == 200) {
        messenger(context, "Profile updated successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PassportPhoto()));
        return;
      }
      messenger(context, "An error occurred");
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  final _bio = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _bio,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                  'Bio Data',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: occupationController,
                    decoration: InputDecoration(
                      labelText: 'Occupation',
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFFFAC30),
                        ),
                      ),
                    ),
                    validator: (value) => value?.isEmpty ?? true
                        ? "Occupation is required"
                        : value!.length < 3
                            ? "Occupation is too short"
                            : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: genderController,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFFFAC30),
                        ),
                      ),
                    ),
                    validator: (value) {
                      // Either Female or Male
                      value = value?.toUpperCase();
                      if (value == "FEMALE" || value == "MALE") return null;
                      return "Gender can either be MALE or FEMALE";
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: dobController,
                    onTap: () async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());
                      dobController.text = date.toString().split(" ")[0];
                    },
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFFFAC30),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Date of birth is required";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                !isLoading
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
                            onPressed: updateProfile,
                            child: Text(
                              'Next',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                      )
                    : const CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: Color(0xFFFFAC30))
              ]),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
