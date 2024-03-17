import 'package:appjam_group13/screens/travel_places_preview.dart';
import 'package:appjam_group13/widgets/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShowMoreScreen extends StatelessWidget {
  const ShowMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowMorePage(),
    );
  }
}

class ShowMorePage extends StatefulWidget {
  const ShowMorePage({super.key});

  @override
  State<ShowMorePage> createState() => _ShowMorePageState();
}

class _ShowMorePageState extends State<ShowMorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              showMoreCard(context),
              showMoreCard(context),
              showMoreCard(context),
              showMoreCard(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
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
      title: Text("Daha Fazla"),
    );
  }
}

Column showMoreCard(context) {
  return Column(
    children: [
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TravelPlacesPreview(
                        travelPlacesId: 15,
                      )));
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  "assets/images/niagarafalls.jpg",
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                // Expanded widget'ını kullanarak metin kutusunu genişletelim
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kuta Resort",
                      style: fontStyle(20, Colors.black, FontWeight.bold),
                    ),
                    Text(
                      "750 TL",
                      style: fontStyle(15, Colors.red, FontWeight.normal),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 15,
                          color: Colors.amber,
                        ),
                        Text(
                          "Italy",
                          style: fontStyle(13, Colors.black, FontWeight.normal),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        "Daha Fazlaasdddddddddddddddddddddddddsaaaaaaaaaaaaaaaa",
                        style: fontStyle(
                            12, Colors.grey.shade700, FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 20),
    ],
  );
}
