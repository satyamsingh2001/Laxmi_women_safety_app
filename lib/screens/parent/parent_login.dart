import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laxmi/constants/custombutton.dart';
import 'package:laxmi/screens/child/bottom_screen/testing.dart';
import 'package:laxmi/screens/parent/parent_register.dart';

import '../../constants/CustomTextField.dart';
import '../../constants/constantcolor.dart';
import '../../constants/constantstring.dart';
import '../../utils/Utils.dart';
import '../child/bottom_screen/child_home_screen.dart';
import '../child/child_register.dart';

class Parent_Login extends StatefulWidget {
  const Parent_Login({Key? key}) : super(key: key);

  @override
  State<Parent_Login> createState() => _Parent_LoginState();
}

class _Parent_LoginState extends State<Parent_Login> {
  @override
  bool isLoading = false;
  bool isVisible = false;
  final _formkey = GlobalKey<FormState>();
  final _fornData =Map<String ,Object>();
  @override
  Widget build(BuildContext context) {

    _onSubmit() async{
      _formkey.currentState!.save();

      try {
        setState(() {
          isLoading = true;
        });
        // progressIndicator(context);
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email:_fornData['gemail'].toString(),
          password: _fornData['password'].toString(),
        );
        if(userCredential != null){
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Child_Home_Screen()));
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          DialogBox(context, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          DialogBox(context, 'Wrong password provided for that user.');
        }
      }
      progressIndicator(context);
      print(_fornData['gemail']);
      print(_fornData['password']);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Stack(
              children: [
                isLoading?progressIndicator(context):
                Column(
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
                    CustomTextField(
                      onsave: (email) {
                        _fornData['gemail'] = email ?? "";
                      },
                      validate: (email){
                        if(email!.isEmpty || email.length<5 || !email.contains("@")){
                          return "Enter valid email address";
                        }else{
                          return null;
                        }
                      },
                      isPassword: false,
                      hintText: "Enter Username",
                      prefix: Icon(Icons.person),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        onsave: (password) {
                          _fornData['password'] = password ?? "";
                        },
                        validate: (password){
                          if(password!.isEmpty || password.length<7){
                            return "Enter min 7 digits";
                          }else{
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
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(ontap: (){
                      if(_formkey.currentState!.validate()){
                        _onSubmit();
                      }
                    }, txt: 'Login',),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Forgot Password?"),
                        TextButton(onPressed: (){}, child: Text("Click here ")),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Register as Child"),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChildRegister()));
                        }, child: Text("Register")),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Register as Parent"),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ParentRegister()));
                        }, child: Text("Register")),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
