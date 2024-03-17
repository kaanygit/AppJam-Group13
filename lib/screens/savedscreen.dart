import 'package:appjam_group13/database/firebase.dart';
import 'package:appjam_group13/widgets/fonts.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late List<dynamic> examList = [];
  bool loadingExamData = true;

  @override
  void initState() {
    super.initState();
    getExamList();
  }

  Future<void> getExamList() async {
    Map<String, dynamic> data = await FirebaseOperations().getProfileBio();
    setState(() {
      examList = data['examList'];
      loadingExamData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: !loadingExamData
          ? examList.length != 0
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: examList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child:
                                        Image.asset("assets/images/test.png"),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Exam ${index + 1}",
                                              style: fontStyle(20, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                print(
                                                    "Delete this exam $index");
                                              },
                                              icon: Icon(Icons.track_changes),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    "${(examList[0]['examList'] as List).length}",
                                                    style: fontStyle(
                                                        15,
                                                        Colors.green,
                                                        FontWeight.normal)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text("Questions",
                                                    style: fontStyle(
                                                        15,
                                                        Colors.grey.shade500,
                                                        FontWeight.normal)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                    "${examList[index]['duration']}",
                                                    style: fontStyle(
                                                        15,
                                                        Colors.black45,
                                                        FontWeight.normal)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text("Duration",
                                                    style: fontStyle(
                                                        15,
                                                        Colors.grey.shade500,
                                                        FontWeight.normal)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: () {
                                            print(
                                                "Starting the test ${index + 1}");
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.amberAccent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12))),
                                          child: Text(
                                            "Start Test",
                                            style: fontStyle(15, Colors.white,
                                                FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        print("Create Exam");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Text(
                        "Create Exam",
                        style: fontStyle(15, Colors.white, FontWeight.normal),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text("Image"),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                print("Create a New Exam");
                              },
                              child: Text(
                                "Create the Exam",
                                style: fontStyle(
                                    30, Colors.pink, FontWeight.normal),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
          : Center(child: Text("Loading")),
    );
  }
}
