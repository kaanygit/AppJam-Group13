import 'package:appjam_group13/screens/buyscreen.dart';
import 'package:appjam_group13/widgets/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    print("Travel ID: ${widget.travelId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              "Londra",
              style: fontStyle(20, Colors.black, FontWeight.bold),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.heart_fill,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
                      child: Image.asset(
                        "assets/images/niagarafalls.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 100,
                        left: 30,
                        child: Text(
                          "Londra",
                          style: fontStyle(25, Colors.white, FontWeight.normal),
                        )),
                    Positioned(
                      bottom: 75,
                      left: 30,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 15,
                            color: Colors.white,
                          ),
                          Text(
                            "Italy",
                            style:
                                fontStyle(15, Colors.white, FontWeight.normal),
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
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
                          style: fontStyle(15, Colors.white, FontWeight.normal),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "What's Included",
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
                    includedMethod(),
                    includedMethod(),
                    includedMethod(),
                    includedMethod(),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "About Trip",
                  style: fontStyle(15, Colors.black, FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bu seyahat, hayatınızın unutulmaz deneyimlerinden biri olacak! Doğanın eşsiz güzelliklerini keşfetmek, farklı kültürlerin tadını çıkarmak ve yeni insanlarla tanışmak için mükemmel bir fırsat. Bu seyahatte muhteşem manzaraların, lezzetli yerel yemeklerin ve heyecan verici aktivitelerin tadını çıkaracaksınız. Enerji dolu bir macera için hazır mısınız? O zaman bu seyahat tam size göre!",
                  style: fontStyle(15, Colors.black, FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "\$750 /Person", // Gezinin fiyatı
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
                          builder: (context) => const BuyScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          ),
        ),
      ),
    );
  }

  Row includedMethod() {
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
                    CupertinoIcons.airplane,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Flight",
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
