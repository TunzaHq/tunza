import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunza/data/requests.dart';
import 'package:tunza/ui/home/drawer_page.dart';
import 'package:tunza/util/file_path.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final requests = Requests();
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).backgroundColor,
        child: FutureBuilder<Map<String, dynamic>?>(
            future: requests.getUser(),
            builder: (context, snapshot) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView(children: [
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
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DrawerPage(
                                child: widget,
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.edit_square)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    child: Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: CircleAvatar(
                        child: SvgPicture.asset(avatorOne),
                        backgroundColor: const Color(0xffFDCF09).withOpacity(1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    child: Text(
                      "John Doe",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Personal Information",
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Email",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const Spacer(),
                        const Text("doe@namani.co")
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Identification Docs",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const Spacer(),
                        const Text("2")
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Phone Number",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const Spacer(),
                        const Text("+254 712 345 678")
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Location",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const Spacer(),
                        const Text("Nairobi, Kenya")
                      ],
                    ),
                  ),
                ]),
              );
            }));
  }
}
