import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunza/data/requests.dart';
import 'package:tunza/ui/auth/bio_data.dart';
import 'package:tunza/ui/plans/covers.dart';
import 'package:tunza/ui/plans/view_plans.dart';
import 'package:tunza/ui/widgets/services.dart';
import 'package:tunza/ui/widgets/widgets.dart';
import 'package:tunza/util/globals.dart';
import 'package:tunza/util/file_path.dart';

class HomePage extends StatefulWidget {
  final bool? hideAlert;
  const HomePage({Key? key, this.hideAlert = true}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Glob {
  final requests = Requests();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(left: 18, right: 18, top: 34),
              child: ListView(
                children: <Widget>[
                  contentHeader(context, widget),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Account Overview',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _contentOverView(),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Active Plans',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<List<Map<String, dynamic>>?>(
                      future: requests.getUserCovers("active"),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return _contentSubscriptions(snapshot.data!.map((e) {
                            print(e);
                            return (e['plan'] as Map<String, dynamic>)
                              ..addAll({"subId": e['id']});
                          }).toList());
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Center(
                            child: Text(
                              'No active plans',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFFFAC30),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Services',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Visibility(
                        visible: false,
                        child: SvgPicture.asset(
                          filter,
                          color: Theme.of(context).iconTheme.color,
                          width: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder<List<Map<String, dynamic>>?>(
                      future: requests.getAllCovers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return contentServices(context, snapshot.data ?? []);
                        }
                        if (snapshot.data?.isEmpty ?? false) {
                          return const Center(
                              child: Text("No covers available"));
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ],
              ),
            ),
            widget.hideAlert!
                ? FutureBuilder<Map<String, dynamic>?>(
                    future: requests.getUser(),
                    builder: (context, snapshot) {
                      return (snapshot.hasData &&
                              snapshot.data!['avatar'].toString().isEmpty)
                          ? BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Card(
                                    color: Theme.of(context).colorScheme.background,
                                    child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Positioned(
                                                top: -24,
                                                left: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2 -
                                                    40,
                                                child: SizedBox(
                                                  height: 48,
                                                  width: 48,
                                                  child: SvgPicture.asset(logo),
                                                )),
                                            SizedBox(
                                                height: 200,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    40,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          'Hello, ${snapshot.data?['full_name']}',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineMedium!
                                                              .copyWith(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        )),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          'Update your profile to get started',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineMedium!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 15),
                                                        )),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    MaterialButton(
                                                      elevation: 0,
                                                      color: const Color(
                                                          0xFFFFAC30),
                                                      height: 40,
                                                      minWidth: 200,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                      onPressed: () async {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const BioData()));
                                                      },
                                                      child: Text(
                                                        'Update Profile',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge
                                                            ?.copyWith(
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        )),
                                  )),
                            )
                          : const SizedBox();
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _contentOverView() {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 22, bottom: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
        // color: const Color(0xffF1F3F6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'kes. 20,600',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Premium Balance',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          ),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: const Color(0xffFFAC30),
              borderRadius: BorderRadius.circular(80),
            ),
            child: const Center(
              child: Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentSubscriptions(List<Map<String, dynamic>> data) {
    var model = data.map((e) => ModelServices(
        title: e['name'], img: e['icon'], id: e['id'], subId: e['subId']));
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 80,
            padding: const EdgeInsets.only(
              left: 18,
              right: 18,
              top: 28,
              bottom: 28,
            ),
            child: InkWell(
              splashColor: const Color(0xffFFAC30),
              onTap: () async => await Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Plans())),
              child: Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  color: Color(0xffFFAC30),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                  ),
                ),
              ),
            ),
          ),
          for (ModelServices cover in model)
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          ViewPlans(id: cover.id!, subId: cover.subId!))),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(16),
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffD8D9E4))),
                      child: CircleAvatar(
                        radius: 22.0,
                        backgroundColor: Theme.of(context).colorScheme.background,
                        child: ClipRRect(
                          child: SvgPicture.asset(
                            send,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                    Text(
                      'Akiba',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
