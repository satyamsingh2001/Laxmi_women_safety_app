import 'package:flutter/material.dart';
import 'package:laxmi/constants/constantcolor.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback ontap;
  final String txt;
  CustomButton({Key? key, required this.ontap, required this.txt}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width*.89,
          height: 45,
          decoration: BoxDecoration(
              color: ConstantColor.button,
              borderRadius: BorderRadius.circular(60)
          ),
          child: Center(child: Text(widget.txt,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
        ),
      ),
    );
  }
}
