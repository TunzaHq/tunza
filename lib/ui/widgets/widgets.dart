import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunza/ui/home/drawer_page.dart';
import 'package:tunza/util/file_path.dart';

Widget contentHeader(BuildContext context, Widget child) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        children: <Widget>[
          SvgPicture.asset(
            logo,
            width: 34,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            'Tunza',
            style: Theme.of(context).textTheme.headline3,
          )
        ],
      ),
      InkWell(
        onTap: () async => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DrawerPage(
                      child: child,
                    ))),
        child: SvgPicture.asset(
          menu,
          width: 16,
          theme: SvgTheme(currentColor: Theme.of(context).iconTheme.color!),
        ),
      ),
    ],
  );
}

Widget claimCard(
        BuildContext context, String title, String date, String amount) =>
    Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFE5E5E5),
              ),
              child: const Icon(
                Icons.money_outlined,
                color: Color(0xFFFFAC30),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Claimed on $date',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            Spacer(),
            Text(
              'Ksh $amount',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
