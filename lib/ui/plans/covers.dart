import 'package:flutter/material.dart';
import 'package:tunza/ui/widgets/services.dart';
import 'package:tunza/ui/widgets/widgets.dart';

class Plans extends StatefulWidget {
  const Plans({super.key});

  @override
  State<Plans> createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                SizedBox(
                  height: 54,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: Theme.of(context).textTheme.bodyText1,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).iconTheme.color!,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).iconTheme.color!,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xFFFFAC30),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'My Plans',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      'View All',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                contentServices(context, 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Top Selling Plans',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                contentServices(context, 3),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Other Plans',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                contentServices(context, 7),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
