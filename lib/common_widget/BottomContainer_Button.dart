import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class BottomContainer extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  BottomContainer({required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: TColor.primaryColor2,
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 80.0,
        padding: EdgeInsets.only(bottom: 15.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }
}