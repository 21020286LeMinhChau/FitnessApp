import 'package:fitness/common_widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/color_extension.dart';

class MealCategoryCell extends StatelessWidget {
  final Map cObj;
  const MealCategoryCell({super.key, required this.cObj});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 100,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          TColor.primaryColor2.withOpacity(0.3),
          TColor.primaryColor1.withOpacity(0.3)
        ]),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            // circle image
            decoration: BoxDecoration(
              color: TColor.white,
              borderRadius: BorderRadius.circular(75),
            ),
            child: Image.asset(
              cObj["image"],
              height: 30,
              width: 30,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            cObj["name"],
            style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          )
        ],
    )
    );

    
  }
}
