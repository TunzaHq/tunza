import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunza/ui/widgets/services.dart';
import 'package:tunza/util/file_path.dart';

class ViewPlans extends StatefulWidget {
  final int id;
  const ViewPlans({super.key, required this.id});

  @override
  State<ViewPlans> createState() => _ViewPlansState();
}

class _ViewPlansState extends State<ViewPlans> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).backgroundColor,
        child: SizedBox(
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
                    onTap: () => Navigator.pop(context),
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
            Align(
              child: Text(
                "Akiba",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Akiba is a savings plan that allows you to save money for a specific period of time and earn interest on your savings. You can save for a period of 3, 6, 9 or 12 months. You can also save for a period of 1, 2, 3, 4 or 5 years. You can save as little as Ksh. 500 and there is no maximum amount you can save. You can save as many times as you want in a day. You can also withdraw your savings at any time.",
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // Pricing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ksh. 500/month",
                      style: Theme.of(context).textTheme.bodyText1
                        ?..copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextButton(
                      child: Text("Subscribe",
                          style: Theme.of(context).textTheme.button!),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFFFAC30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // other related plans
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Simillar products",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: contentServices(context, 3),
            )
          ]),
        ));
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
