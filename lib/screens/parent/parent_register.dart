import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laxmi/login.dart';


import '../../constants/CustomTextField.dart';
import '../../constants/constantcolor.dart';
import '../../constants/constantstring.dart';
import '../../constants/custombutton.dart';
import '../../models/user_model.dart';
import '../../utils/Utils.dart';

class ParentRegister extends StatefulWidget {
  const ParentRegister({Key? key}) : super(key: key);

  @override
  State<ParentRegister> createState() => _ParentRegisterState();
}

class _ParentRegisterState extends State<ParentRegister> {
  bool isLoading = false;
  bool isVisible = false;
  bool isVisibleR = false;
  final _formkey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();




  _onSubmit() async {
    _formkey.currentState!.save();
    if (_formData['password'] != _formData['rpassword']) {
      DialogBox(context, 'password and retype password should be equal');
    } else {
      progressIndicator(context);
      try {
        setState(() {
          isLoading = true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _formData['gemail'].toString(),
            password: _formData['password'].toString());
        if (userCredential.user != null) {
          final v = userCredential.user!.uid;
          DocumentReference<Map<String, dynamic>> db =
          FirebaseFirestore.instance.collection('users').doc(v);
          final user = User_Model(
              name: _formData['name'].toString(),
              phone: _formData['phone'].toString(),
              childemail: _formData['cemail'].toString(),
              parentemail: _formData['gemail'].toString(),
              id: v,
              type: 'parent'
          );
          final jsonData = user.toJson();
          await db.set(jsonData).whenComplete(() {
            goTo(context, Base_Login());
            Utils.showToastMsg("Registered Successfully");
            setState(() {
              isLoading = false;
            });
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          DialogBox(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          DialogBox(context, 'The account already exists for that email.');
        }
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
        });
        DialogBox(context, e.toString());
      }
    }
    print(_formData['gemail']);
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
              isLoading?progressIndicator(context):
              Column(
                children: [
                  Text(
                    "REGISTER AS PARENT",
                    style: TextStyle(
                        color: ConstantColor.button,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    parent,height:200
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height *0.5,
                    // color: Colors.red,
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          CustomTextField(
                            onsave: (name) {
                              _formData['name'] = name ?? "";
                            },
                            validate: (name) {
                              if (name!.isEmpty) {
                                return "Name can't be null";
                              } else {
                                return null;
                              }
                            },
                            isPassword: false,
                            hintText: "Enter Your Name",
                            prefix: Icon(Icons.person),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            onsave: (phone) {
                              _formData['phone'] = phone ?? "";
                            },
                            validate: (phone) {
                              if (phone!.isEmpty || phone.length < 10) {
                                return "Enter valid number";
                              } else {
                                return null;
                              }
                            },
                            maxLength: 10,
                            isPassword: false,
                            keyboard: TextInputType.phone,
                            hintText: "Enter Your Mobile Number",
                            prefix: Icon(Icons.phone),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            onsave: (email) {
                              _formData['gemail'] = email ?? "";
                            },
                            validate: (email) {
                              if (email!.isEmpty ||
                                  email.length < 5 ||
                                  !email.contains("@")) {
                                return "Enter valid email address";
                              } else {
                                return null;
                              }
                            },
                            isPassword: false,
                            hintText: "Enter Your Email address",
                            prefix: Icon(Icons.email),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // CustomTextField(
                          //   onsave: (cemail) {
                          //     _formData['cemail'] = cemail ?? "";
                          //   },
                          //   validate: (email) {
                          //     if (email!.isEmpty ||
                          //         email.length < 5 ||
                          //         !email.contains("@")) {
                          //       return "Enter valid email address";
                          //     } else {
                          //       return null;
                          //     }
                          //   },
                          //   isPassword: false,
                          //   hintText: "Enter Your Child Email address",
                          //   prefix: Icon(Icons.email),
                          // ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                              onsave: (password) {
                                _formData['password'] = password ?? "";
                              },
                              validate: (password) {
                                if (password!.isEmpty || password.length < 7) {
                                  return "Enter min 7 digits";
                                } else {
                                  return null;
                                }
                              },
                              isPassword: !isVisible,
                              hintText: "Enter Password",
                              prefix: Icon(Icons.key),
                              suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  child: Icon(isVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                              onsave: (password) {
                                _formData['rpassword'] = password ?? "";
                              },
                              validate: (password) {
                                if (password!.isEmpty || password.length < 7) {
                                  return "Enter min 7 digits";
                                } else {
                                  return null;
                                }
                              },
                              isPassword: !isVisibleR,
                              hintText: "Re-Enter Password",
                              prefix: Icon(Icons.key),
                              suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isVisibleR = !isVisibleR;
                                    });
                                  },
                                  child: Icon(isVisibleR
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                          SizedBox(
                            height: 8,
                          ),
                          CustomButton(
                            ontap: () {
                              if (_formkey.currentState!.validate()) {
                                _onSubmit();
                              }
                            },
                            txt: 'Register',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already Member?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Base_Login()));
                          },
                          child: Text("Login")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
