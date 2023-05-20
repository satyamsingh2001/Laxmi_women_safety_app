import 'package:flutter/material.dart';

class Parent_Home_Screen extends StatefulWidget {
  const Parent_Home_Screen({Key? key}) : super(key: key);

  @override
  State<Parent_Home_Screen> createState() => _Parent_Home_ScreenState();
}

class _Parent_Home_ScreenState extends State<Parent_Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Hello"),);
  }
}
