import 'package:flutter/material.dart';

class TestScreenTwo extends StatefulWidget {
  const TestScreenTwo({super.key});

  @override
  State<TestScreenTwo> createState() => _TestScreenTwoState();
}

class _TestScreenTwoState extends State<TestScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("TestScreenTwo"),
      ),
    );
  }
}
