import 'package:appjam_group13/database/firebase.dart';
import 'package:appjam_group13/screens/authscreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseOperations _firebaseOperations = FirebaseOperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Çıkış yap butonuna basıldığında Firebase üzerinden çıkış yap
              await _firebaseOperations.signOut();
              // Çıkış yapıldıktan sonra giriş ekranına geri dön
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(child: Text("Home Screen")),
    );
  }
}
