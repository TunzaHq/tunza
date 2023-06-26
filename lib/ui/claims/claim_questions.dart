import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunza/data/requests.dart';
import 'package:tunza/ui/widgets/widgets.dart';
import 'package:tunza/util/file_path.dart';

class ClaimQuestions extends StatefulWidget {
  final int coverId;
  final int subId;
  const ClaimQuestions({super.key, required this.coverId, required this.subId});

  @override
  State<ClaimQuestions> createState() => _ClaimQuestionsState();
}

class _ClaimQuestionsState extends State<ClaimQuestions> {
  final requests = Requests();

  int? tappedIndex;
  Map<int?, String?> answers = {};
  bool isUploading = false;

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(
            'Claim',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: [
            TextButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                final result =
                    await requests.createClaim(widget.coverId, widget.subId, answers);
                setState(() {
                  isLoading = false;
                });
                if (result) {
                  Navigator.pop(context);
                } else {
                  messenger(context, "Failed to submit claim");
                }
              },
              child: Text(
                'Submit',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: SvgPicture.asset(
                  mainBanner,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FutureBuilder<List<Map<String, dynamic>>?>(
                        future: requests.getQuestions(widget.coverId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            final data = snapshot.data!;
                            return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tappedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 50,
                                    ),
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).cardColor,
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Badge(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme.background,
                                                  label: Text("${index + 1}"),
                                                  textColor: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.color,
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    data[index]['question']),
                                              ),
                                              Icon(
                                                data[index]['expects'] == "text"
                                                    ? Icons.text_fields
                                                    : Icons.image,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color,
                                                size: 12,
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          data[index]['expects'] == "text"
                                              ? tappedIndex == index
                                                  ? SizedBox(
                                                      height: 44,
                                                      child: TextFormField(
                                                        initialValue:
                                                            answers[index],
                                                        onChanged: (value) {
                                                          answers[data[index]
                                                              ['id']] = value;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        )),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 44,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey[700]!),
                                                      ),
                                                      child: Text(answers[
                                                              data[index]
                                                                  ['id']] ??
                                                          ''),
                                                    )
                                              : answers.containsKey(
                                                      data[index]['id'])
                                                  ? Container(
                                                      height: 100,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey[700]!),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  answers[data[
                                                                          index]
                                                                      ['id']]!),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    )
                                                  : Container(
                                                      height: 100,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey[700]!),
                                                      ),
                                                      child: isUploading
                                                          ? const Align(
                                                              child: SizedBox(
                                                                height: 32,
                                                                width: 32,
                                                                child:
                                                                    CircularProgressIndicator
                                                                        .adaptive(
                                                                  valueColor: AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Colors
                                                                          .grey),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xFFFFAC30),
                                                                ),
                                                              ),
                                                            )
                                                          : GestureDetector(
                                                              onTap: () async {
                                                                setState(() {
                                                                  isUploading =
                                                                      true;
                                                                });
                                                                var file = await ImagePicker()
                                                                    .pickImage(
                                                                        source:
                                                                            ImageSource.gallery);
                                                                final url = await requests
                                                                    .uploadFile(
                                                                        File(file!
                                                                            .path),
                                                                        "OTHER");
                                                                setState(() {
                                                                  answers[data[
                                                                          index]
                                                                      [
                                                                      'id']] = url;
                                                                  isUploading =
                                                                      false;
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .add_a_photo,
                                                                color: Colors
                                                                    .grey[700],
                                                              ),
                                                            ),
                                                    )
                                        ]),
                                  ),
                                ),
                              ),
                            );
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text("No questions found"),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }))),
            isLoading
                ? const Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 32,
                      width: 32,
                      child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                        backgroundColor: Color(0xFFFFAC30),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
