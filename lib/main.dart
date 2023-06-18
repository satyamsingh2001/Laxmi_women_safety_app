import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laxmi/constants/constantcolor.dart';
import 'package:laxmi/constants/constantstring.dart';
import 'package:laxmi/db/shared_preference.dart';
import 'package:laxmi/login.dart';
import 'package:laxmi/screens/child/bottom_page.dart';
import 'package:laxmi/screens/parent/parent_home_screen.dart';
import 'package:laxmi/utils/Utils.dart';
import 'package:laxmi/utils/background_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MyShared_Pref.init();
  // await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // scaffoldMessengerKey: navigatorkey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.firaSansTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.blue,
        ),
        home:Splash_Screen()
    );
  }
}

class Splash_Screen extends StatelessWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
          FutureBuilder(
              future: MyShared_Pref.getUserType(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.data==""){
                  return Base_Login();
                }
                if(snapshot.data=="child"){
                  return Bottom_Page();
                }
                if(snapshot.data=="parent"){
                  return ParentHomeScreen();
                }
                return progressIndicator(context);
              })
      ));
    });
    return Container(
      color: Colors.white,
      child:Image.asset(splash)
    );
  }
}

