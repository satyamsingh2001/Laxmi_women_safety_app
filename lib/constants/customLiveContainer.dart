import 'package:flutter/material.dart';

class CustomLiveContainer extends StatefulWidget {

  CustomLiveContainer({Key? key, required this.ontap, required this.text, required this.img, }) : super(key: key);

  final VoidCallback ontap;
  final String text;

  final String img;


  @override
  State<CustomLiveContainer> createState() => _CustomLiveContainerState();
}

class _CustomLiveContainerState extends State<CustomLiveContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.ontap,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child:Image.asset(widget.img)),
              ),
            ),
          ),
          Text(widget.text,style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
