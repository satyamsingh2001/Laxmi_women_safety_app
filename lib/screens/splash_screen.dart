import 'dart:async';

import 'package:flutter/material.dart';
import 'package:laxmi/constants/constantstring.dart';
import 'package:laxmi/db/shared_preference.dart';
import 'package:laxmi/login.dart';
import 'package:laxmi/screens/child/bottom_page.dart';
import 'package:laxmi/screens/parent/parent_home_screen.dart';
import 'package:laxmi/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {

 @override
  void initState() {

   Timer(Duration(seconds: 2), () async{


     // Get.off(clientid == null?Auth_Page():Home());
     // FutureBuilder(
     //     future: MyShared_Pref.getUserType(),
     //     builder: (BuildContext context, AsyncSnapshot snapshot){
     //       if(snapshot.data==""){
     //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Base_Login()));
     //       }
     //       if(snapshot.data=="child"){
     //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Bottom_Page()));
     //
     //       }
     //       if(snapshot.data=="parent"){
     //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Parent_Home_Screen()));
     //
     //       }
     //       return progressIndicator(context);
     //     });
   });

   // TODO: implement initState
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(splash,fit: BoxFit.fill,),
    );
  }
}
