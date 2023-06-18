import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laxmi/constants/CustomTextField.dart';
import 'package:laxmi/constants/constantcolor.dart';
import 'package:laxmi/constants/constantstring.dart';
import 'package:laxmi/constants/custombutton.dart';
import 'package:laxmi/db/shared_preference.dart';
import 'package:laxmi/screens/parent/parent_register.dart';

import 'utils/Utils.dart';
import 'screens/parent/parent_home_screen.dart';
import 'screens/child/bottom_page.dart';
import 'screens/child/child_register.dart';

class Base_Login extends StatefulWidget {
  const Base_Login({Key? key}) : super(key: key);

  @override
  State<Base_Login> createState() => _Base_LoginState();
}

class _Base_LoginState extends State<Base_Login> {
  @override
  bool isLoading = false;
  bool isVisible = false;
  final _formkey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
  }
  
  _onSubmit() async {
    _formkey.currentState!.save();
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _formData['cemail'].toString(),
              password: _formData['password'].toString());
      if (userCredential.user != null) {
        setState(() {
          isLoading = false;
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((value) {
          if (value['type'] == 'parent') {
            print(value['type']);
            MyShared_Pref.saveUserType('parent');
            goTo(context, ParentHomeScreen());
          } else {
            MyShared_Pref.saveUserType('child');

            goTo(context, Bottom_Page());
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        DialogBox(context, 'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        DialogBox(context, 'Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              isLoading
                  ? progressIndicator(context)
                  : SingleChildScrollView(
                    child: Column(
                        children: [
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(height: 20,),
                                Text(
                                  "USER LOGIN",
                                  style: TextStyle(
                                      color: ConstantColor.button,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset(
                                  girl,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Form(
                              key: _formkey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomTextField(
                                    onsave: (email) {
                                      _formData['cemail'] = email ?? "";
                                    },
                                    validate: (email) {
                                      if (email!.isEmpty ||
                                          email.length < 5 ||
                                          !email.contains("@")) {
                                        return "Enter valid email address";
                                      }
                                      else {
                                        return null;
                                      }
                                    },
                                    isPassword: false,
                                    hintText: "Enter Username",
                                    prefix: Icon(Icons.person),
                                  ),
                                  CustomTextField(
                                      onsave: (password) {
                                        _formData['password'] = password ?? "";
                                      },
                                      validate: (password) {
                                        if (password!.isEmpty ||
                                            password.length < 7) {
                                          return "Enter min 7 digits";
                                        } else {
                                          return null;
                                        }
                                      },
                                      isPassword: !isVisible,
                                      hintText: "Enter Password",
                                      prefix: Icon(Icons.lock),
                                      suffix: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isVisible = !isVisible;
                                            });
                                          },
                                          child: Icon(isVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility))),
                                  CustomButton(
                                    ontap: () {
                                      if (_formkey.currentState!.validate()) {
                                        _onSubmit();
                                      }
                                    },
                                    txt: 'Login',
                                  ),
                                ],
                              ),
                            ),
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Forgot Password?"),
                              TextButton(
                                  onPressed: () {}, child: Text("Click here ")),
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChildRegister()));
                              },
                              child: Text("Register as Child")),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ParentRegister()));
                              },
                              child: Text("Register as Parent")),
                        ],
                      ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
