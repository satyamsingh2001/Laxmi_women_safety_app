import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:laxmi/constants/constantcolor.dart';
import 'package:url_launcher/url_launcher.dart';



class Utils{


  static void showToastMsg(String? msg, {bool isErrorType = false}) {

    Fluttertoast.showToast(
        msg: msg!,
        backgroundColor: isErrorType ? Colors.red : Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5);
  }

  static Future<void> openMap(String location) async {

    String googleUrl = "https://www.google.com/maps/search/$location";
    final Uri _url = Uri.parse(googleUrl);


    try{

      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }catch(e){
      Utils.showToastMsg("Something went wrong");
    }
  }

  static Future<void> callNumber(String number) async{

    await FlutterPhoneDirectCaller.callNumber(number);
  }

}

Widget progressIndicator(BuildContext context){
  return Center(child:CircularProgressIndicator(
    backgroundColor: ConstantColor.button,
    color: Colors.white,
  ));
}

DialogBox(BuildContext context ,String text){
  showDialog(context: context, builder: (context)=>AlertDialog(
    title: Text(text),
  ));
}

void goTo(BuildContext context, Widget nextScreen) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ));
}
