import 'package:GezginAt/database/firebase.dart';
import 'package:GezginAt/screens/travel_places_preview.dart';
import 'package:GezginAt/widgets/fonts.dart';
import 'package:GezginAt/widgets/loading.dart';
import 'package:GezginAt/widgets/not_found.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<Map<String, dynamic>> savedPlaces = [];
  Map<String, dynamic> userProfile = {};

  bool loadingExamData = true;
  late int likedId;

  @override
  void initState() {
    super.initState();
    fetchBookmark();
    likedId = 0;
  }

  Future<void> likedPlaces(int id) async {
    Map<String, dynamic> data = await FirebaseOperations().getProfileBio();
    int isLiked = 0;
    for (var x in data['savedPlaces']) {
      if (x == id) {
        isLiked = id;
        break;
      }
    }
    FirebaseOperations().setProfileLikedTravel(id);
    setState(() {
      likedId = isLiked;
    });
  }

  Future<void> fetchBookmark() async {
    Map<String, dynamic> data = await FirebaseOperations().getProfileBio();
    List<Map<String, dynamic>> placeData = [];
    for (var x in data['savedPlaces']) {
      savedPlaces.add(await FirebaseOperations().getFirebaseTravelDataId(x));
    }
    print(placeData);
    setState(() {
      userProfile = data;
      loadingExamData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: !loadingExamData
          ? savedPlaces.length != 0
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: savedPlaces.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 2.0, color: Colors.grey.shade300)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TravelPlacesPreview(
                                                travelPlacesId:
                                                    savedPlaces[index]['id'],
                                              )));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        // "assets/images/niagarafalls.jpg",
                                        "${savedPlaces[index]['resim']}",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
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
                                                // "${savedPlaces[index]['isim']}",
                                                shortenText(
                                                    savedPlaces[index]['isim']),
                                                style: fontStyle(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.bold),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  print("heart icon");

                                                  likedPlaces(
                                                      savedPlaces[index]['id']);
                                                },
                                                icon: Icon(
                                                  CupertinoIcons.heart_fill,
                                                  color: (likedId ==
                                                              savedPlaces[index]
                                                                  ['id'] ||
                                                          userProfile[
                                                                  'likedPlaces']
                                                              .contains(
                                                                  savedPlaces[
                                                                          index]
                                                                      ['id']))
                                                      ? Colors.red
                                                      : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 15,
                                                    color: Colors.amber,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      "${savedPlaces[index]['konumu']}",
                                                      style: fontStyle(
                                                          15,
                                                          Colors.grey.shade500,
                                                          FontWeight.normal)),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                      "${savedPlaces[index]['ücreti']} TL",
                                                      style: fontStyle(
                                                          15,
                                                          Colors.red.shade500,
                                                          FontWeight.normal)),
                                                ],
                                              ),
                                              Container(
                                                child: Text(
                                                  "${savedPlaces[index]['hakkında']}",
                                                  style: fontStyle(
                                                      15,
                                                      Colors.grey.shade500,
                                                      FontWeight.normal),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/notfoundbookmark.png",
                          width: 300,
                          height: 300,
                        ),
                      ),
                      SizedBox(height: 20), // Added some spacing
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Kaydedilmiş Seyahat Bulunamadı!",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
          : LoadingWidget(
              width: 300,
              height: 300,
            ),
    );
  }

  String shortenText(String text, {int maxLength = 12}) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }
}
