import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunza/ui/home/drawer_page.dart';
import 'package:tunza/ui/plans/covers.dart';
import 'package:tunza/ui/plans/view_plans.dart';
import 'package:tunza/ui/widgets/services.dart';
import 'package:tunza/ui/widgets/widgets.dart';
import 'package:tunza/util/file_path.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
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
                style: Theme.of(context).textTheme.headline4,
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
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _contentSubscriptions(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Services',
                    style: Theme.of(context).textTheme.headline4,
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
              contentServices(context, 6),
            ],
          ),
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
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Premium Balance',
                style: Theme.of(context).textTheme.headline4!.copyWith(
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

  Widget _contentSubscriptions() {
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
              onTap: () => Navigator.push(
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
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ViewPlans(id: 12))),
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
                      backgroundColor: Theme.of(context).backgroundColor,
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
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            ),
          ),
          Container(
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
                      border: Border.all(color: const Color(0xffD8D9E4))),
                  child: CircleAvatar(
                    radius: 22.0,
                    backgroundColor: Theme.of(context).backgroundColor,
                    child: ClipRRect(
                      child: SvgPicture.asset(
                        cashback,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                Text(
                  'Britam Biashara',
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Container(
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
                      border: Border.all(color: const Color(0xffD8D9E4))),
                  child: CircleAvatar(
                    radius: 22.0,
                    backgroundColor: Theme.of(context).backgroundColor,
                    child: ClipRRect(
                      child: SvgPicture.asset(
                        electricity,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                Text(
                  'Fire & Burglary',
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
