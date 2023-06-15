import 'package:flutter/material.dart';
import 'package:tunza/data/requests.dart';
import 'package:tunza/ui/widgets/widgets.dart';

class Claims extends StatefulWidget {
  const Claims({super.key});

  @override
  State<Claims> createState() => _ClaimsState();
}

class _ClaimsState extends State<Claims> {
  final TextEditingController _searchController = TextEditingController();

  final request = Requests();

  var claims = [];

  Future<void> getClaims() async {
    var response = await request.getClaims();
    for (var claim in response ?? []) {
      claims.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Card(
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
                      Icons.shopping_cart_outlined,
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
                        'Biashara Claim',
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Claimed on 12/12/2020',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    'Ksh 14, 000',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Padding(
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
                        borderSide: const BorderSide(
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
                      'Recent Claims',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      'View All',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...claims.take(3).toList(),
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
                              'Akiba Claim',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Claimed on 12/12/2020',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          'Ksh 10,000',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
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
                      'Submitted Claims',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                claimCard(context, "Akiba", "12/12/2002", "45,000")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
