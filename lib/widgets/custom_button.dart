import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.onTap,
    required this.text,
  });
  VoidCallback? onTap;

  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFB022561), borderRadius: BorderRadius.circular(8)),
        width: double.infinity,
        height: 40,
        child: Center(
            child: Text(
              text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
      ),
    );
  }
}
