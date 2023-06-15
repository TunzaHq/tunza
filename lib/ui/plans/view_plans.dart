import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunza/data/requests.dart';
import 'package:tunza/ui/widgets/services.dart';
import 'package:tunza/util/globals.dart';
import 'package:tunza/util/file_path.dart';

class ViewPlans extends StatefulWidget {
  final int id, subId;
  final List<Map<String, dynamic>>? simillar;
  const ViewPlans(
      {super.key, required this.id, required this.subId, this.simillar});

  @override
  State<ViewPlans> createState() => _ViewPlansState();
}

class _ViewPlansState extends State<ViewPlans> with Glob {
  final requests = Requests();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
        future: requests.getCoverById(widget.id),
        builder: (context, snapshot) {
          final Map<String, dynamic>? data = snapshot.data;
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

                  data != null
                      ? Align(
                          child: Text(
                            "${data['name']}",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 40,
                  ),
                  data != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${data['description']}",
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
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
                            "Ksh. ${data != null ? data['price'] : 0}",
                            style: Theme.of(context).textTheme.bodyText1
                              ?..copyWith(
                                  color: Theme.of(context).primaryColor),
                          ),
                        ),
                        const Spacer(),
                        FutureBuilder<List<Map<String, dynamic>>?>(
                            future: requests.getUserCovers(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final cover = snapshot.data?.firstWhere(
                                    (element) =>
                                        element['plan_id'] == widget.id,
                                    orElse: () => {});
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: cover?.isNotEmpty ?? false
                                      ? TextButton(
                                          child: Text("Claim",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button!),
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFFFAC30),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {},
                                        )
                                      : TextButton(
                                          child: Text("Subscribe",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button!),
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFFFAC30),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {},
                                        ),
                                );
                              }
                              return const SizedBox.shrink();
                            })
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
                    child: contentServices(context, widget.simillar ?? []),
                  )
                ]),
              ));
        });
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
