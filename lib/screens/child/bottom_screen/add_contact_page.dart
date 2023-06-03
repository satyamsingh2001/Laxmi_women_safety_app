import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laxmi/constants/constantcolor.dart';
import 'package:laxmi/constants/custombutton.dart';
import 'package:laxmi/db/db_services.dart';
import 'package:laxmi/models/contants_model.dart';
import 'package:laxmi/screens/child/bottom_screen/contact_page.dart';
import 'package:laxmi/utils/Utils.dart';
import 'package:sqflite/sqlite_api.dart';

class Add_Contact_Page extends StatefulWidget {
  const Add_Contact_Page({Key? key}) : super(key: key);

  @override
  State<Add_Contact_Page> createState() => _Add_Contact_PageState();
}

class _Add_Contact_PageState extends State<Add_Contact_Page> {
  DatabaseHelper databasehelper = DatabaseHelper();
  List<Contact_Model> contactList = [];
  int count = 0;

  void showList() {
    Future<Database> dbFuture = databasehelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Contact_Model>> contactListFuture =
      databasehelper.geContact_ModelList();
      contactListFuture.then((value) {
        setState(() {
          this.contactList = value;
          this.count = value.length;
        });
      });
    });
  }

  void deleteContact(Contact_Model contact) async {
    int result = await databasehelper.deleteContact(contact.id);
    if (result != 0) {
      Utils.showToastMsg("contact removed succesfully");
      showList();
    }
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showList();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                CustomButton(ontap: () async{
                 bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>Contact_Page()));
                 if (result == true) {
                   showList();
                 }
                }, txt: "Add Trusted Contacts"),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: count,
                    itemBuilder: (context, index){
                    return Card(
                      child: ListTile(
                        title: Text(contactList[index].number),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await FlutterPhoneDirectCaller.callNumber(
                                        contactList[index].name);
                                  },
                                  icon: Icon(
                                    Icons.call,
                                    color: ConstantColor.call,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    deleteContact(contactList[index]);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: ConstantColor.delete,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                }),
              ],
            ),
          )
      ),
    );
  }
}
