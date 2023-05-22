import 'package:flutter/material.dart';
import 'package:laxmi/constants/constantcolor.dart';
import 'package:laxmi/widgets/home_widgets/custom_carousal.dart';

import '../../../widgets/home_widgets/emergency/emergency.dart';
import '../../../widgets/home_widgets/livesafe/livesafe.dart';
import '../../../widgets/share_locations/share_loc.dart';

class Child_Home_Screen extends StatefulWidget {
  const Child_Home_Screen({Key? key}) : super(key: key);

  @override
  State<Child_Home_Screen> createState() => _Child_Home_ScreenState();
}

class _Child_Home_ScreenState extends State<Child_Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text("Laxmi"
                , style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width*0.07,
                    color: ConstantColor.button
                ),
              ),
              SizedBox(height: 10,),
              CustomCarouel(),
              SizedBox(height: 10,),
              Text("Emergency"
                , style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // fontSize: MediaQuery.of(context).size.width*0.06,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 10,),
              Emergency(),
              SizedBox(height: 10,),
              Text("Explore Livesafe"
                , style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // fontSize: MediaQuery.of(context).size.width*0.06,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 10,),
              Livesafe(),
              SizedBox(height: 10,),
              ShareLocation(),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("@ Proudly made by Kmcians"
                  , style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: MediaQuery.of(context).size.width*0.06,
                      color: Colors.grey
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
