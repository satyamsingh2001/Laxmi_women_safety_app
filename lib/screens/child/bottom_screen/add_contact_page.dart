import 'package:flutter/material.dart';
import 'package:laxmi/constants/custombutton.dart';
import 'package:laxmi/screens/child/bottom_screen/contact_page.dart';
import 'package:laxmi/utils/Utils.dart';

class Add_Contact_Page extends StatelessWidget {
  const Add_Contact_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                CustomButton(ontap: (){
                  goTo(context, Contact_Page());
                }, txt: "Add Trusted Contacts"),
              ],
            ),
          )
      ),
    );
  }
}
