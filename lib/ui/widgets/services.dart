import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunza/ui/plans/view_plans.dart';

Widget contentServices(BuildContext context, List<Map<String, dynamic>> data) {
  print("Data hereree $data");
  List<ModelServices> listServices = data
      .map((value) => ModelServices(
            title: value['name'],
            img: value['icon'],
            id: value['id'],
            subId: value['subId'],
          ))
      .toList();

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
                    builder: (context) => ViewPlans(
                      id: value.id!,
                      subId: value.subId ?? -1,
                      simillar: data,
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
          .take(6)
          .toList(),
    ),
  );
}

class ModelServices {
  String title, img;
  int? id, subId;
  ModelServices(
      {required this.title, required this.img, required this.id, this.subId});
}
