import 'package:flutter/material.dart';


import '../../../constants/constantstring.dart';
import '../../../constants/customContainer.dart';
import '../../../utils/Utils.dart';



class Emergency extends StatefulWidget {

  const Emergency({Key? key}) : super(key: key);

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {


  @override
  void initState() {
    super.initState();
    // Utils.callNumber();
  }
  @override
  Widget build(BuildContext context) {



    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          CustomContiner(
              ontap: (){

                Utils.callNumber('6393604028');
              },
              head: 'Active Emergency', subhead: 'Call 1090 for women helpline',
              number: 'Helpline', img: alert),
          CustomContiner(
              ontap: () {
                Utils.callNumber('109');
              },
              head: 'Police', subhead: 'In case of police emergency call',
              number: '1-0-9', img: police),
          CustomContiner(
              ontap: () {
                Utils.callNumber('102');
              },
              head: 'Ambulance', subhead: 'In case of medical emergency call',
              number: '1-0-2', img: ambulance),
          CustomContiner(
              ontap: () {
                Utils.callNumber('101');
              },
              head: 'Fire Brigade', subhead: 'In case of fire emergency call',
              number: '1-0-1', img: fire),


        ],
      ),
    );
  }

}

