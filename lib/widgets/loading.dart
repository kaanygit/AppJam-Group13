import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double width, height;

  const LoadingWidget({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Image.asset(
            "assets/images/icon.png",
            width: width, // Doğrudan width'e eriş
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
