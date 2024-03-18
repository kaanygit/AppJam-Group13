import 'package:appjam_group13/database/firebase.dart';
import 'package:appjam_group13/screens/chatscreen.dart';
import 'package:appjam_group13/screens/homepagescreen.dart';
import 'package:appjam_group13/screens/profilescreen.dart';
import 'package:appjam_group13/screens/savedscreen.dart';

import 'package:appjam_group13/widgets/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int _selectedIndex = 0;
  bool _loadingValue = false;
  Map<String, dynamic> userProfile = {};
  late String greetingMessage = "";

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ChatScreen(),
    SavedScreen(),
    ProfileScreen(),
  ];

  List<String> selectedName = ["", "Chat", "Saved Places", "Profile"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfileData();
  }

  @override
  void dispose() {
    // Burada temizlik işlemleri yapabilirsiniz
    super.dispose();
  }

  Future<void> fetchProfileData() async {
    Map<String, dynamic> user = await FirebaseOperations().getProfileBio();
    DateTime now = DateTime.now();
    String greeting = '';

    if (now.hour >= 0 && now.hour < 6) {
      greeting = 'İyi Geceler';
    } else if (now.hour >= 6 && now.hour < 12) {
      greeting = 'Günaydın';
    } else if (now.hour >= 12 && now.hour < 18) {
      greeting = 'İyi Öğlenler';
    } else if (now.hour >= 18 && now.hour < 24) {
      greeting = 'İyi Akşamlar';
    }

    setState(() {
      userProfile = user;
      greetingMessage =
          greeting; // greeting değişkenini greetingMessage olarak atadık
      _loadingValue = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loadingValue
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: _selectedIndex == 0
                      ? Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: (userProfile['profilePhoto'] == null ||
                                      userProfile['profilePhoto'] == "")
                                  ? Image.asset(
                                      'assets/images/placeholder.png',
                                      width: 50,
                                      height: 50,
                                    )
                                  : Image.network(
                                      userProfile['profilePhoto'],
                                      width: 50,
                                      height: 50,
                                    ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    !(userProfile['displayName'] == null ||
                                            userProfile['displayName'] == "")
                                        ? "Merhaba ${userProfile['displayName']}"
                                        : "Merhaba Name",
                                    style: fontStyle(
                                        15, Colors.black, FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "$greetingMessage",
                                  style: fontStyle(
                                      15, Colors.black, FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        )
                      : Text(
                          "${selectedName[_selectedIndex]}",
                          style: fontStyle(25, Colors.black, FontWeight.bold),
                        )),
            ),
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: GNav(
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    gap: 8,
                    activeColor: Colors.lightGreen,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: Duration(milliseconds: 400),
                    tabBackgroundColor: Colors.grey[100]!,
                    color: Colors.black,
                    tabs: [
                      GButton(
                        icon: CupertinoIcons.compass,
                        text: 'Home',
                      ),
                      GButton(
                        icon: CupertinoIcons.chat_bubble,
                        text: 'Chat',
                      ),
                      GButton(
                        icon: CupertinoIcons.bookmark,
                        text: 'Saved',
                      ),
                      GButton(
                        icon: CupertinoIcons.person_crop_circle,
                        text: 'Profile',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            body: Text("Loading"),
          );
  }
}
