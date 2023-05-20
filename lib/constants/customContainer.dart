import 'package:flutter/material.dart';
import 'package:laxmi/constants/constantcolor.dart';

class CustomContiner extends StatefulWidget {

  CustomContiner({Key? key, required this.ontap, required this.head, required this.subhead, required this.number, required this.img}) : super(key: key);

  final VoidCallback ontap;
  final String head;
  final String subhead;
  final String number;
  final String img;


  @override
  State<CustomContiner> createState() => _CustomContinerState();
}

class _CustomContinerState extends State<CustomContiner> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width*0.68,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors:[
                  ConstantColor.con1,
                  ConstantColor.con2,
                  ConstantColor.con3,
                ]
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(widget.img.toString(),),
              ),
              Text(widget.head,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width*0.06,
                    color: Colors.white
                ),),
              Text(widget.subhead,
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width*0.035,
                    color: Colors.white
                ),),

              Padding(
                padding: const EdgeInsets.fromLTRB(80, 10, 0, 5),
                child: GestureDetector(
                  onTap: widget.ontap,
                  child: Container(
                    height: 25,
                    width: MediaQuery.of(context).size.width/5,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: Text(widget.number,
                      style: TextStyle(color: ConstantColor.textC),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
