// import 'package:appjam_group13/database/firebase.dart';
// import 'package:appjam_group13/screens/travel_places_preview.dart';
// import 'package:appjam_group13/widgets/fonts.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class ShowMoreScreen extends StatelessWidget {
//   const ShowMoreScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ShowMorePage(),
//     );
//   }
// }

// class ShowMorePage extends StatefulWidget {
//   const ShowMorePage({super.key});

//   @override
//   State<ShowMorePage> createState() => _ShowMorePageState();
// }

// class _ShowMorePageState extends State<ShowMorePage> {
//   int selectedTextIndex = 0;
//   late bool _loadingValue = false;
//   List<Map<String, dynamic>> travelData = [];
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       List<Map<String, dynamic>> travels =
//           await FirebaseOperations().getFirebaseTravelData();
//       // await FirebaseOperations().gesssss();
//       setState(() {
//         print(travels);
//         travelData = travels;
//         _loadingValue = true;
//       });
//     } catch (e) {
//       print("Veri alınamadı: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: _loadingValue
//               ? Column(
//                   children: [
//                     for (int i = 0; i < travelData.length; i++)
//                       showMoreCard(context, i),
//                   ],
//                 )
//               : Text("Loading"),
//         ),
//       ),
//     );
//   }

//   AppBar appBar(BuildContext context) {
//     return AppBar(
//       leading: GestureDetector(
//         onTap: () {
//           print("Geri düğmesine basıldı");
//           Navigator.pop(context);
//         },
//         child: Container(
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       title: Text("Daha Fazla"),
//     );
//   }
// }

// Column showMoreCard(context, int i) {
//   return Column(
//     children: [
//       InkWell(
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const TravelPlacesPreview(
//                         travelPlacesId: travelData[i]['id'],
//                       )));
//         },
//         child: Container(
//           padding: EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             border: Border.all(width: 2.0, color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(25),
//                 child: Image.network(
//                   "${travelData[i]['resim']}",
//                   width: 100,
//                   height: 100,
//                 ),
//               ),
//               SizedBox(width: 15),
//               Expanded(
//                 // Expanded widget'ını kullanarak metin kutusunu genişletelim
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "${travelData[i]['isim']}",
//                       style: fontStyle(20, Colors.black, FontWeight.bold),
//                     ),
//                     Text(
//                       "${travelData[i]['ücreti']} TL",
//                       style: fontStyle(15, Colors.red, FontWeight.normal),
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.location_on,
//                           size: 15,
//                           color: Colors.amber,
//                         ),
//                         Text(
//                           "${travelData[i]['konumu']}",
//                           style: fontStyle(13, Colors.black, FontWeight.normal),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       child: Text(
//                         "${travelData[i]['hakkında']}",
//                         style: fontStyle(
//                             12, Colors.grey.shade700, FontWeight.normal),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       SizedBox(height: 20),
//     ],
//   );
// }

import 'package:appjam_group13/database/firebase.dart';
import 'package:appjam_group13/screens/travel_places_preview.dart';
import 'package:appjam_group13/widgets/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShowMoreScreen extends StatelessWidget {
  const ShowMoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowMorePage(),
    );
  }
}

class ShowMorePage extends StatefulWidget {
  const ShowMorePage({Key? key}) : super(key: key);

  @override
  State<ShowMorePage> createState() => _ShowMorePageState();
}

class _ShowMorePageState extends State<ShowMorePage> {
  int selectedTextIndex = 0;
  late bool _loadingValue = false;
  List<Map<String, dynamic>> travelData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> travels =
          await FirebaseOperations().getFirebaseTravelData();
      setState(() {
        travelData = travels;
        _loadingValue = true;
      });
    } catch (e) {
      print("Veri alınamadı: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: _loadingValue
              ? Column(
                  children: [
                    for (int i = 0; i < travelData.length; i++)
                      showMoreCard(context, i, travelData),
                  ],
                )
              : Text("Loading"),
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

Column showMoreCard(
    BuildContext context, int i, List<Map<String, dynamic>> travelData) {
  return Column(
    children: [
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TravelPlacesPreview(
                        travelPlacesId: travelData[i]['id'],
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
                child: Image.network(
                  "${travelData[i]['resim']}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                // Expanded widget'ını kullanarak metin kutusunu genişletelim
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${travelData[i]['isim']}",
                      style: fontStyle(20, Colors.black, FontWeight.bold),
                    ),
                    Text(
                      "${travelData[i]['ücreti']} TL",
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
                          "${travelData[i]['konumu']}",
                          style: fontStyle(13, Colors.black, FontWeight.normal),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        "${travelData[i]['hakkında']}",
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
