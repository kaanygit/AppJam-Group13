import 'package:appjam_group13/screens/chatscreen.dart';
import 'package:appjam_group13/screens/homepagescreen.dart';
import 'package:appjam_group13/screens/profilescreen.dart';
import 'package:appjam_group13/screens/savedscreen.dart';

import 'package:appjam_group13/widgets/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ChatScreen(),
    SavedScreen(),
    ProfileScreen(),
  ];

  List<String> selectedName = ["", "Chat", "Saved Places", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: _selectedIndex == 0
                ? Row(
                    children: [
                      Image.asset(
                        'assets/images/placeholder.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello Name",
                            style: fontStyle(15, Colors.black, FontWeight.bold),
                          ),
                          Text(
                            "Good Morning!",
                            style: fontStyle(15, Colors.black, FontWeight.bold),
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
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
    );
  }
}
