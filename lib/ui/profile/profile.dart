import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tunza/data/requests.dart';
import 'package:tunza/ui/home/drawer_page.dart';
import 'package:tunza/ui/widgets/widgets.dart';
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
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: FutureBuilder<Map<String, dynamic>?>(
            future: requests.getUser(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final user = snapshot.data!;
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () =>
                                messenger(context, "Functionality disabled"),
                            child: const Icon(Icons.edit_square))
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "${user['avatar']}",
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                            errorBuilder: (context, error, stackTrace) =>
                                SvgPicture.asset(avatorOne),
                          ),
                        ),
                        backgroundColor: const Color(0xffFDCF09).withOpacity(1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    child: Text(
                      "${user['full_name']}",
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
                        Text("${user['email']}")
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
                          "Date Of Birth",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const Spacer(),
                        Text("${user['dob'].toString().split('T')[0]}")
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
                          "Occupation",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const Spacer(),
                        Text("${user['occupation']}")
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
                          "Identification Documents",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const Spacer(),
                        Text("${user['media'].length}"),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.open_in_new,
                          size: 12,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<List<Placemark>>(
                      future: placemarkFromCoordinates(
                          double.parse(
                              user['location'].toString().split(',')[0]),
                          double.parse(
                              user['location'].toString().split(',')[1])),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text(
                                "Location",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              const Spacer(),
                              Text("${snapshot.data![0].locality}")
                            ],
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Occupation",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const Spacer(),
                        Text("${user['occupation']}")
                      ],
                    ),
                  ),
                ]),
              );
            }));
  }
}
