import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laxmi/chat_module/chat_screen.dart';
import 'package:laxmi/constants/CustomTextField.dart';
import 'package:laxmi/db/shared_preference.dart';
import 'package:laxmi/login.dart';
import 'package:laxmi/screens/child/bottom_page.dart';
import 'package:laxmi/screens/parent/parent_home_screen.dart';
import 'package:laxmi/utils/Utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MyShared_Pref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
        
       

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




       
       
        // MyShared_Pref.getUserType()=="Child"
        //     ? Child_Home_Screen()
        //     :MyShared_Pref.getUserType()=="Parent"
        // ?Parent_Home_Screen()
        // :Login_Screen()
    );
  }
}


//
// FutureBuilder(
// future: MyShared_Pref.getUserType(),
// builder: (BuildContext context, AsyncSnapshot snapshot) {
// if (snapshot.hasData == "") {
// Navigator.push(context,
// MaterialPageRoute(builder: (context) => Login_Screen()));
// }
// if (snapshot.hasData == "Parent") {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Parent_Home_Screen()));
// }
// if (snapshot.hasData == "Child") {
// Navigator.push(context,
// MaterialPageRoute(builder: (context) => Bottom_Page()));
// }
//
// return progressIndicator(context);
// }));