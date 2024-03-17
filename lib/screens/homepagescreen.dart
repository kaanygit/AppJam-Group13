import 'package:appjam_group13/database/firebase.dart';
import 'package:appjam_group13/screens/showmore.dart';
import 'package:appjam_group13/screens/travel_places_preview.dart';
import 'package:appjam_group13/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTextIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    funciton();
  }

  Future<void> funciton() async {
    await FirebaseOperations().setFirebaseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Explore the\nBeautiful world!",
                    style: fontStyle(20, Colors.black, FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoSearchTextField(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        prefixInsets: EdgeInsets.only(left: 8),
                        placeholder: 'Search Places',
                        onChanged: (String value) {
                          print(value);
                        },
                        onSubmitted: (String value) {
                          print("submit value : $value");
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          print("Seçenekleri aç");
                        },
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.lightGreen,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Travel Places",
                        style:
                            fontStyle(20, Colors.lightGreen, FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            print("Show more Buttonu");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ShowMoreScreen()));
                          },
                          child: Text("Show more >",
                              style: fontStyle(
                                  13, Colors.grey, FontWeight.normal)))
                    ],
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildRotatedText("Popular", 0),
                          SizedBox(height: 10),
                          buildRotatedText("Latest", 1),
                          SizedBox(height: 10),
                          buildRotatedText("All", 2),
                        ],
                      ),
                      SizedBox(width: 10),

                      ///
                      TravelPlacesCard(),
                      TravelPlacesCard(),

                      ///
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Schedule",
                        style:
                            fontStyle(20, Colors.lightGreen, FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          print("Show More");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ShowMoreScreen()));
                        },
                        child: Text("Show more >",
                            style:
                                fontStyle(13, Colors.grey, FontWeight.normal)),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                MyScheduleCard(),
                MyScheduleCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column MyScheduleCard() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(15)),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TravelPlacesPreview(
                            travelPlacesId: 15,
                          )));
            },
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/images/niagarafalls.jpg",
                              width: 75,
                              height: 75,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Niagara Falls",
                                style: fontStyle(
                                    14, Colors.black, FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 15,
                                    color: Colors.lightGreen,
                                  ),
                                  Text(
                                    "Canada",
                                    style: fontStyle(
                                        13, Colors.grey, FontWeight.normal),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print("Button clicked");
                        },
                        child: Text(
                          "Joined",
                          style: fontStyle(12, Colors.white, FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            minimumSize: Size(30, 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  InkWell TravelPlacesCard() {
    return InkWell(
      onTap: () {
        print("Karta tıklandı");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TravelPlacesPreview(
                      travelPlacesId: 15,
                    )));
      },
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        "assets/images/niagarafalls.jpg",
                        width: 150,
                        height: 150,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                        bottom: 30,
                        right: 5,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "750TL",
                            style: fontStyle(12, Colors.white, FontWeight.bold),
                          ),
                        ))
                  ],
                ),
                Text(
                  "City Rome",
                  style: fontStyle(15, Colors.black, FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 15,
                          color: Colors.lightGreen,
                        ),
                        Text(
                          "Italy",
                          style: fontStyle(13, Colors.black, FontWeight.normal),
                        ),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(
                                10) // burada border radius uygulanıyor
                            ),
                        child: Text("5 Days",
                            style: fontStyle(
                                13, Colors.grey.shade900, FontWeight.normal)))
                  ],
                )
              ],
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget buildRotatedText(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTextIndex = index;
        });
      },
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          text,
          style: fontStyle(
            12,
            selectedTextIndex == index ? Colors.lightGreen : Colors.grey,
            FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
