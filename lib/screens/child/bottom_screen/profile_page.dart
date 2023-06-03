import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laxmi/constants/CustomTextField.dart';
import 'package:laxmi/constants/constantcolor.dart';
import 'package:laxmi/constants/constantstring.dart';
import 'package:laxmi/constants/custombutton.dart';
import 'package:laxmi/utils/Utils.dart';
import 'package:uuid/uuid.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({Key? key}) : super(key: key);

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  TextEditingController nameC = TextEditingController();

  final key = GlobalKey<FormState>();

  String? id;

  String? profilePic;

  String? downloadUrl;

  bool isSaving = false;

  getDate() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        nameC.text = value.docs.first['name'];
        id = value.docs.first.id;
        profilePic = value.docs.first['profilePic'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      isSaving==true?progressIndicator(context)
      :SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Center(
            child:Form(
              key: key,
              child: Column(
                children: [
                Text("UPDATE YOUR PROFILE"
                , style: GoogleFonts.lobster(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width*0.08,
                  color: ConstantColor.button
              ),
                ),SizedBox(height: 15,),
                  GestureDetector(
                    onTap: () async {
                      final XFile? pickImage = await ImagePicker()
                          .pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50);
                      if (pickImage != null) {
                        setState(() {
                          profilePic = pickImage.path;
                        });
                      }
                    },
                    child: Container(
                      child: profilePic == null
                          ? CircleAvatar(
                        // backgroundColor: Colors.deepPurple,
                        backgroundImage: AssetImage(update_photo),
                        radius: 80,
                        // child: Center(
                        //     child: Image.asset(
                        //       update_photo,
                        //       height: 80,
                        //       width: 80,
                        //     )),
                      )
                          : profilePic!.contains('http')
                          ? CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        radius: 80,
                        backgroundImage:
                        NetworkImage(profilePic!),
                      )
                          : CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          radius: 80,
                          backgroundImage:
                          FileImage(File(profilePic!))),
                    ),
                  ),
                  CustomTextField(isPassword: false,
                  validate: (v){
                    if(v!.isEmpty){
                      return "Please enter updated name";
                    }
                  },
                  controller: nameC,
                  hintText: nameC.text,
                  ),
                  SizedBox(height: 25),

                  CustomButton(ontap: ()  async{
                    if(key.currentState!.validate()){
                      SystemChannels.textInput.invokeMethod("TextInput.hide");
                      profilePic == null
                          ? Utils.showToastMsg(
                          'please select profile picture')
                          : update();
                    }

                  }, txt: "Update")
                ],
              ),
            )
          ),
        ),
      )
    );
  }

  Future<String?> uploadImage(String filePath) async {
    try {
      final filenName = Uuid().v4();
      final Reference fbStorage =
      FirebaseStorage.instance.ref('profile').child(filenName);
      final UploadTask uploadTask = fbStorage.putFile(File(filePath));
      await uploadTask.then((p0) async {
        downloadUrl = await fbStorage.getDownloadURL();
      });
      return downloadUrl;
    } catch (e) {
      Utils.showToastMsg( e.toString());
    }
  }

  update() async {
    setState(() {
      isSaving = true;
    });
    uploadImage(profilePic!).then((value) {
      Map<String, dynamic> data = {
        'name': nameC.text,
        'profilePic': downloadUrl,
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data);
      setState(() {
        isSaving = false;
      });
    });
  }
}
