import 'package:flutter/material.dart';

import '../../constants/constantstring.dart';

class ShareLocation extends StatefulWidget {
  const ShareLocation({Key? key}) : super(key: key);

  @override
  State<ShareLocation> createState() => _ShareLocationState();
}

class _ShareLocationState extends State<ShareLocation> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>showBottomSheet(context: context, builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height/1.7,
          color: Colors.red,
        );
      }),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text(
                        "Share Location",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Share Location",
                        style: TextStyle(),
                      ),
                    ),

                  ],
                ),
              ),
              Image.asset(shareLocation,width: 200,) ,
            ],
          ),
        ),
      ),
    );
  }
}
