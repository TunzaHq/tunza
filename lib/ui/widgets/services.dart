import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunza/ui/plans/view_plans.dart';
import 'package:tunza/util/file_path.dart';

Widget contentServices(BuildContext context, int take) {
  List<ModelServices> listServices = [];

  listServices.add(ModelServices(title: "Akiba", img: send));
  listServices.add(ModelServices(title: "Sacco Solution", img: recive));
  listServices.add(ModelServices(title: "Cyber Insurance", img: mobile));
  listServices.add(ModelServices(title: "Fire & Burglary", img: electricity));
  listServices.add(ModelServices(title: "Britam Biashara", img: cashback));
  listServices.add(ModelServices(title: "Family Insurance", img: movie));
  listServices.add(ModelServices(title: "Travel Insurance", img: flight));
  //listServices.add(ModelServices(title: "More\nOptions", img: menu));

  return SizedBox(
    width: double.infinity,
    child: Wrap(
      runSpacing: 10,
      spacing: 10,
      alignment: WrapAlignment.spaceBetween,
      children: listServices
          .map((value) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewPlans(
                      id: 1,
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: 100,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).cardColor,
                      ),
                      child: SvgPicture.asset(
                        value.img,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      value.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
            );
          })
          .toList()
          .take(take)
          .toList(),
    ),
  );
}

class ModelServices {
  String title, img;
  ModelServices({required this.title, required this.img});
}
