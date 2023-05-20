import 'package:flutter/material.dart';
import 'package:laxmi/constants/constantcolor.dart';
import 'package:laxmi/screens/child/bottom_screen/chat_page.dart';
import 'package:laxmi/screens/child/bottom_screen/child_home_screen.dart';
import 'package:laxmi/screens/child/bottom_screen/contact_page.dart';
import 'package:laxmi/screens/child/bottom_screen/profile_page.dart';
import 'package:laxmi/screens/child/bottom_screen/review_page.dart';

class Bottom_Page extends StatefulWidget {
  const Bottom_Page({Key? key}) : super(key: key);

  @override
  State<Bottom_Page> createState() => _Bottom_PageState();
}

class _Bottom_PageState extends State<Bottom_Page> {
  int _currentindex = 0;
  final Screen = [
    Child_Home_Screen(),
    Chat_Screem(),
    Contact_Page(),
    Profile_Page(),
    Review_Page(),



  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Screen[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        type: BottomNavigationBarType.shifting,
        // fixedColor: Colors.white,
        // unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor:ConstantColor.button),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
            backgroundColor:ConstantColor.button),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Contacts',
            backgroundColor:ConstantColor.button),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Profile',
            backgroundColor:ConstantColor.button),
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: 'Review',
            backgroundColor: ConstantColor.button,),

        ],
        onTap: (index){
          setState(() {
            _currentindex = index;
          });
        },
      ),

    );
  }
}