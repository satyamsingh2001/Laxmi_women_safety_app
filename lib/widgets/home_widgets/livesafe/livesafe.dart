import 'package:flutter/material.dart';

import '../../../constants/constantstring.dart';
import '../../../constants/customLiveContainer.dart';
import '../../../utils/Utils.dart';

class Livesafe extends StatefulWidget {
  const Livesafe({Key? key}) : super(key: key);

  @override
  State<Livesafe> createState() => _LivesafeState();
}

class _LivesafeState extends State<Livesafe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      // color: Colors.red,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          CustomLiveContainer(
            ontap: () {
              Utils.openMap("Police Station near me");
            },
            text: 'Police Station',
            img: policeBadge,
          ),
          CustomLiveContainer(
            ontap: () {
              Utils.openMap("Hospital near me");
            },
            text: 'Hospital',
            img: hospital,
          ),
          CustomLiveContainer(
            ontap: () {
              Utils.openMap("Bus Stop near me");
            },
            text: 'Bus Stop',
            img: bus,
          ),
          CustomLiveContainer(
            ontap: () {
              Utils.openMap("Pharmacy near me");
            },
            text: 'Pharmacy',
            img: pharmacy,
          ),
          CustomLiveContainer(
            ontap: () {
              Utils.openMap("Temple near me");
            },
            text: 'Temple',
            img: temple,
          ),

        ],
      ),
    );
  }
}
