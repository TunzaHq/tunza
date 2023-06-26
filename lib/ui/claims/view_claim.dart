import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunza/data/requests.dart';
import 'package:tunza/util/file_path.dart';
import 'package:tunza/util/globals.dart';

class ViewClaim extends StatefulWidget {
  final int claimId;
  const ViewClaim({super.key, required this.claimId});

  @override
  State<ViewClaim> createState() => _ViewClaimState();
}

class _ViewClaimState extends State<ViewClaim> {
  final request = Requests();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Claim'),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FutureBuilder<Map<String, dynamic>?>(
          future: request.getUserClaim(widget.claimId),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(logo),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Badge(
                      label: Text(snapshot.data!['status']),
                      child: Text(
                        snapshot.data!['cover']['plan']['name'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(snapshot.data?['cover']['plan']['description']),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Claim Details",
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        snapshot.data?['description'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                          DateTime.parse(snapshot.data?['createdAt']).yyyyMMdd),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Estimated Amount",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle:
                          Text("Kes. ${snapshot.data!['amount'].toString()}"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Questionnaire Status",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(snapshot.data!['answers'].isNotEmpty
                          ? "Completed"
                          : "Pending"),
                    ),
                  ),
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasData) {
              return const Center(
                child: Text('No Data'),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                backgroundColor: Color(0xFFFFAC30),
              ),
            );
          },
        ),
      ),
    );
  }
}
