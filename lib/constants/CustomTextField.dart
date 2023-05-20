import 'package:flutter/material.dart';
import 'package:laxmi/constants/constantcolor.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final String? Function(String?)? onsave;
  final bool isPassword;
  final TextInputType? keyboard;
  final int? maxLength;
  final Widget ? suffix;
  final Widget ? prefix;

  CustomTextField({Key? key, this.hintText, this.controller, this.validate, this.onsave, required this.isPassword, this.keyboard, this.suffix, this.prefix, this.maxLength}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: widget.maxLength,
        keyboardType: widget.keyboard==null?TextInputType.name:widget.keyboard,
        onSaved: widget.onsave,
        validator: widget.validate,
        controller: widget.controller,
        obscureText: widget.isPassword,
        // key: _formKey,
        // keyboardType: TextInputType.number,
        cursorHeight: 25,
        decoration: InputDecoration(
            counterText: "",
            filled: true,
            fillColor: ConstantColor.txtfld,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: ConstantColor.bordertxt.withOpacity(0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
            // border: OutlineInputBorder(),
            hintText: widget.hintText,
            contentPadding: EdgeInsets.only(left: 20, top: 15)));
  }
}
