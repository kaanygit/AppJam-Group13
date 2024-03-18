import 'package:GezginAt/database/firebase.dart';
import 'package:GezginAt/screens/showmore.dart';
import 'package:GezginAt/screens/travel_places_preview.dart';
import 'package:GezginAt/widgets/flash_message.dart';
import 'package:GezginAt/widgets/fonts.dart';
import 'package:GezginAt/widgets/not_found.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTextIndex = 0;
  List<Map<String, dynamic>> travelData = [];
  Map<String, dynamic> userProfile = {};
  List<Map<String, dynamic>> orderTravelPlaces = [];
  List<Map<String, dynamic>> filteredTravelData = [];

  late bool _loadingValue = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> travels =
          await FirebaseOperations().getFirebaseTravelData();
      Map<String, dynamic> data = await FirebaseOperations().getProfileBio();
      for (var x in data['joinedPlaces']) {
        orderTravelPlaces
            .add(await FirebaseOperations().getFirebaseTravelDataId(x));
      }
      print(orderTravelPlaces);
      setState(() {
        print(travels);
        travelData = travels;
        filteredTravelData = travels;
        _loadingValue = true;
      });
    } catch (e) {
      print("Veri alınamadı: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            child: _loadingValue
                ? travelData.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Güzel Dünyayı \nKeşfedin ve Tadını Çıkarın!",
                              style:
                                  fontStyle(20, Colors.black, FontWeight.bold),
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
                                    showSuccessSnackBar(context,
                                        "Merhaba şuan geliştirme aşamasındayız. Çok yakında bu özelliğe erişebileceksin!");
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
                                    showSuccessSnackBar(context,
                                        "Merhaba şuan geliştirme aşamasındayız. Çok yakında bu özelliğe erişebileceksin!");
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
                                  "Seyahat Yerleri",
                                  style: fontStyle(
                                      20, Colors.lightGreen, FontWeight.bold),
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
                                    child: Text("Daha Fazla >",
                                        style: fontStyle(13, Colors.grey,
                                            FontWeight.normal)))
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    buildRotatedText("Popüler", 0),
                                    SizedBox(height: 10),
                                    buildRotatedText("En Son", 1),
                                    SizedBox(height: 10),
                                    buildRotatedText("Hepsi", 2),
                                  ],
                                ),
                                SizedBox(width: 10),

                                ///
                                for (int i = 1; i <= 4; i++)
                                  TravelPlacesCard(travelData[i]),

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
                                  "Seyahatlerim",
                                  style: fontStyle(
                                      20, Colors.lightGreen, FontWeight.bold),
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
                                  child: Text("Daha Fazla >",
                                      style: fontStyle(
                                          13, Colors.grey, FontWeight.normal)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          for (int i = 0; i < orderTravelPlaces.length; i++)
                            MyScheduleCard(i),
                        ],
                      )
                    : const NotFoundScreen()
                : const Column(
                    children: [
                      CardLoading(
                        height: 100,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CardLoading(
                        height: 100,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CardLoading(
                        height: 100,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Column MyScheduleCard(int index) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 2.0, color: Colors.grey.shade300)),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TravelPlacesPreview(
                            travelPlacesId: orderTravelPlaces[index]['id'],
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
                            child: Image.network(
                              "${orderTravelPlaces[index]['resim']}",
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
                                "${orderTravelPlaces[index]['isim']}",
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
                                    "${orderTravelPlaces[index]['konumu']}",
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TravelPlacesPreview(
                                        travelPlacesId: orderTravelPlaces[index]
                                            ['id'],
                                      )));
                        },
                        child: Text(
                          "Joined",
                          style: fontStyle(12, Colors.white, FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            minimumSize: Size(30, 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
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

  InkWell TravelPlacesCard(Map<String, dynamic> travelData) {
    int travelId = int.tryParse(travelData['id'].toString()) ?? 0;
    return InkWell(
      onTap: () {
        print("Karta tıklandı");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TravelPlacesPreview(
                      travelPlacesId: travelId,
                    )));
      },
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2.0, color: Colors.grey.shade300)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        "${travelData['resim']}", // Örnek bir URL
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 20,
                        right: 5,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "${travelData['ücreti']} TL",
                            style: fontStyle(12, Colors.white, FontWeight.bold),
                          ),
                        ))
                  ],
                ),
                Text(
                  "${travelData['isim']}",
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
                          "${travelData['konumu']}",
                          style: fontStyle(13, Colors.black, FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                10) // burada border radius uygulanıyor
                            ),
                        child: Text("${travelData['gün']} Gün",
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
