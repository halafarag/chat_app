import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  CustomTextFeild({required this.onChanged, this.hintText,this.obscureText=false});
  Function(String)? onChanged;
  String? hintText;
bool? obscureText;
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      obscureText:obscureText! ,
      validator: (value) {
        if (value!.isEmpty) {
          return 'feild is reqiued';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFFB022561)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFB022561))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFB022561))),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFB022561))),
      ),
    );
  }
}
