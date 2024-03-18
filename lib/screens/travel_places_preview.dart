import 'package:GezginAt/database/firebase.dart';
import 'package:GezginAt/screens/buyscreen.dart';
import 'package:GezginAt/widgets/fonts.dart';
import 'package:GezginAt/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TravelPlacesPreview extends StatelessWidget {
  final int travelPlacesId;

  const TravelPlacesPreview({Key? key, required this.travelPlacesId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TravelPlaces(
          travelId: travelPlacesId), // TravelPlaces önizleme ekranını göster
    );
  }
}

class TravelPlaces extends StatefulWidget {
  final int travelId;

  const TravelPlaces({Key? key, required this.travelId}) : super(key: key);

  @override
  State<TravelPlaces> createState() => _TravelPlacesState();
}

class _TravelPlacesState extends State<TravelPlaces> {
  late bool _loadingValue = false;
  bool ordered = false;
  Map<String, dynamic> travelIdData = {};
  late bool bookmark;
  late bool liked;
  @override
  void initState() {
    super.initState();
    print("Travel ID: ${widget.travelId}");
    fetchTravelIdData();
    bookmark = false;
    liked = false;
  }

  Future<void> fetchTravelIdData() async {
    Map<String, dynamic> getTravelData =
        await FirebaseOperations().getFirebaseTravelDataId(widget.travelId);
    Map<String, dynamic> data = await FirebaseOperations().getProfileBio();

    setState(() {
      travelIdData = getTravelData;
      fetchBookmarkAndLiked();
      ordered = ordered;
      ordered = data['joinedPlaces'].contains(widget.travelId);
      print(" Satın alma:$ordered");

      _loadingValue = true;
    });
  }

  Future<void> fetchBookmarkAndLiked() async {
    Map<String, dynamic> getProfileData =
        await FirebaseOperations().getProfileBio();
    setState(() {
      bookmark = getProfileData['savedPlaces'].contains(widget.travelId);
      liked = getProfileData['likedPlaces'].contains(widget.travelId);
      liked ? Colors.red : Colors.black;
      // Renk değişimini burada gerçekleştir
      bookmark ? Colors.blue : Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _loadingValue
          ? AppBar(
              leading: GestureDetector(
                onTap: () {
                  print("Geri düğmesine basıldı");
                  Navigator.pop(context);
                },
                child: Container(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${travelIdData['isim']}",
                    style: fontStyle(20, Colors.black, FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          FirebaseOperations()
                              .setProfileLikedTravel(travelIdData['id']);
                          fetchTravelIdData();
                        },
                        icon: Icon(
                          CupertinoIcons.heart_fill,
                          color: liked ? Colors.red : Colors.black,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            FirebaseOperations()
                                .setProfileJoinedBookmarks(travelIdData['id']);
                            fetchTravelIdData();
                          },
                          icon: Icon(
                            CupertinoIcons.bookmark_fill,
                            color: bookmark ? Colors.blue : Colors.black,
                          ))
                    ],
                  ),
                ],
              ),
            )
          : null,
      body: _loadingValue
          ? SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: double
                                    .infinity, // Genişliği tamamen kaplaması için
                                height: 300, // Belirli bir yükseklik
                                child: Image.network(
                                  "${travelIdData['resim']}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 100,
                                left: 30,
                                child: Text(
                                  "${travelIdData['isim']}",
                                  style: fontStyle(
                                      25, Colors.white, FontWeight.normal),
                                )),
                            Positioned(
                              bottom: 75,
                              left: 30,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 15,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    "${travelIdData['konumu']}",
                                    style: fontStyle(
                                        15, Colors.white, FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 165,
                              bottom: 20,
                              child: Transform.scale(
                                scale:
                                    0.3, // Rating barı küçültmek için ölçekleme faktörü
                                child: RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 30,
                                left: 110,
                                child: Text(
                                  "4.8",
                                  style: fontStyle(
                                      15, Colors.white, FontWeight.normal),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Neler İçeriyor ?",
                          style: fontStyle(15, Colors.black, FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            includedMethod("Uçak"),
                            includedMethod("Otel"),
                            includedMethod("Ulaşım"),
                            includedMethod("Vize"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Seyahat Hakkında",
                          style: fontStyle(15, Colors.black, FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${travelIdData['hakkında']}",
                          style: fontStyle(15, Colors.black, FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Yorumlar",
                              style:
                                  fontStyle(15, Colors.black, FontWeight.bold),
                            ),
                          ),
                          // SizedBox(
                          //   height: 16,
                          // ),
                          // Container(
                          //   alignment: Alignment.center,
                          //   child: Text(
                          //     "Yorumlar Kısmı",
                          //     style:
                          //         fontStyle(25, Colors.black, FontWeight.bold),
                          //   ),
                          // )
                        ],
                      )
                    ],
                  )),
            )
          : LoadingWidget(width: 300, height: 300),
      bottomNavigationBar: _loadingValue
          ? BottomAppBar(
              color: !ordered ? Colors.white : Colors.blue,
              child: Container(
                child: !ordered
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${travelIdData['ücreti']} TL / Kişi", // Gezinin fiyatı
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BuyScreen(
                                          travelId: travelIdData['id'])));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                "Satın Al", // Buton metni
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Satın Alındı 👏",
                          style: fontStyle(25, Colors.white, FontWeight.bold),
                        ),
                      ),
              ),
            )
          : null,
    );
  }

  Row includedMethod(String include) {
    IconData iconData;

    // İstenen simgeye göre ikonu belirle
    switch (include) {
      case "Uçak":
        iconData = CupertinoIcons.airplane;
        break;
      case "Otel":
        iconData = CupertinoIcons.house_alt;
        break;
      case "Ulaşım":
        iconData = CupertinoIcons.car;
        break;
      case "Vize":
        iconData = CupertinoIcons.book;
      default:
        // Varsayılan olarak "add" simgesini kullan
        iconData = CupertinoIcons.add;
    }
    return Row(
      children: [
        Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1.5, color: Colors.grey.shade300)),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100),
                  child: Icon(
                    iconData,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "${include}",
                  style: fontStyle(15, Colors.black, FontWeight.bold),
                ),
              ],
            )),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
