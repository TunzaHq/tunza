import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunza/ui/home/drawer_page.dart';
import 'package:tunza/util/file_path.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final List<Item> _data = generateItems(8);

  static List<Item> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return Item(
        headerValue: 'Item $index',
        expandedValue: 'This is item number $index',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).colorScheme.background,
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
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DrawerPage(
                          child: widget,
                        ),
                      ),
                    ),
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
            const Align(
              child: Text(
                "Help",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
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
                child: Text("Contact Us",
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Email",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  const Text("help@tunza.io")
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Free Call",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  const Text("+254 712 345 678")
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Telegram",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  const Text("@tunza")
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child:
                    Text("FAQs", style: Theme.of(context).textTheme.bodyLarge),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ExpansionPanelList(
                  expandedHeaderPadding: EdgeInsets.zero,
                  dividerColor: Theme.of(context).colorScheme.background,
                  elevation: 0,
                  expandIconColor: const Color(0xFFFFAC30),
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _data[index].isExpanded = !isExpanded;
                    });
                  },
                  children: _data.map<ExpansionPanel>((Item item) {
                    return ExpansionPanel(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(item.headerValue,
                              style: Theme.of(context).textTheme.bodyMedium),
                        );
                      },
                      body: ListTile(
                          title: Text(item.expandedValue),
                          subtitle: const Text(
                              'To delete this panel, tap the trash can icon'),
                          trailing: const Icon(Icons.delete),
                          onTap: () {
                            setState(() {
                              _data.removeWhere(
                                  (Item currentItem) => item == currentItem);
                            });
                          }),
                      isExpanded: item.isExpanded,
                    );
                  }).toList(),
                ),
              ),
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
