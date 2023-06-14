import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunza/ui/claims/claims.dart';
import 'package:tunza/ui/plans/covers.dart';
import 'package:tunza/ui/help/help.dart';
import 'package:tunza/ui/home/home_page.dart';
import 'package:tunza/ui/profile/profile.dart';
import 'package:tunza/util/file_path.dart';

class DrawerPage extends StatefulWidget {
  final Widget child;
  const DrawerPage({Key? key, required this.child}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> with TickerProviderStateMixin {
  bool sideBarActive = true;
  late AnimationController rotationController;
  @override
  void initState() {
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: RotatedBox(
                        quarterTurns: 1,
                        child: SvgPicture.asset(
                          mainBanner,
                          fit: BoxFit.cover,
                        )))),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(60)),
                          color: Theme.of(context).backgroundColor),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xffD8D9E4))),
                              child: CircleAvatar(
                                radius: 22.0,
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                child: ClipRRect(
                                  child: SvgPicture.asset(avatorOne),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "John Doe",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  "Nairobi, Kenya",
                                  style: Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()))
                              },
                          child:
                              navigatorTitle("Home", widget.child is HomePage)),
                      GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Plans()))
                              },
                          child:
                              navigatorTitle("Plans", widget.child is Plans)),
                      GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Claims()))
                              },
                          child:
                              navigatorTitle("Claims", widget.child is Claims)),
                      GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Profile()))
                              },
                          child: navigatorTitle(
                              "Profile", widget.child is Profile)),
                      GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Help()))
                              },
                          child: navigatorTitle("Help", widget.child is Help)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 24,
                        color: Theme.of(context).iconTheme.color,
                        // color: sideBarActive ? Colors.black : Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Logout",
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Ver 0.1.1",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left:
                  (sideBarActive) ? MediaQuery.of(context).size.width * 0.6 : 0,
              top: (sideBarActive)
                  ? MediaQuery.of(context).size.height * 0.2
                  : 0,
              child: RotationTransition(
                turns: (sideBarActive)
                    ? Tween(begin: -0.05, end: 0.0).animate(rotationController)
                    : Tween(begin: 0.0, end: -0.05).animate(rotationController),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: (sideBarActive)
                      ? MediaQuery.of(context).size.height * 0.7
                      : MediaQuery.of(context).size.height,
                  width: (sideBarActive)
                      ? MediaQuery.of(context).size.width * 0.8
                      : MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: sideBarActive
                        ? const BorderRadius.all(Radius.circular(40))
                        : const BorderRadius.all(Radius.circular(0)),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                      borderRadius: sideBarActive
                          ? const BorderRadius.all(Radius.circular(40))
                          : const BorderRadius.all(Radius.circular(0)),
                      child: widget.child),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 20,
              child: (sideBarActive)
                  ? IconButton(
                      padding: const EdgeInsets.all(30),
                      onPressed: closeSideBar,
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).iconTheme.color,
                        size: 30,
                      ),
                    )
                  : InkWell(
                      onTap: openSideBar,
                      child: Container(
                        margin: const EdgeInsets.all(17),
                        height: 30,
                        width: 30,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Row navigatorTitle(String name, bool isSelected) {
    return Row(
      children: [
        (isSelected)
            ? Container(
                width: 5,
                height: 40,
                color: const Color(0xffffac30),
              )
            : const SizedBox(
                width: 5,
                height: 40,
              ),
        const SizedBox(
          width: 10,
          height: 45,
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 16,
                fontWeight: (isSelected) ? FontWeight.w700 : FontWeight.w400,
              ),
        ),
      ],
    );
  }

  void openSideBar() {
    setState(() {
      sideBarActive = true;
    });
    rotationController.forward();
  }

  void closeSideBar() {
    setState(() {
      sideBarActive = false;
    });
    rotationController.reverse();
  }
}
