import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class IngredientNextRow extends StatelessWidget {
  final Map nObj;
  const IngredientNextRow({super.key, required this.nObj});

  @override
  Widget build(BuildContext context) {
    // return image, value and title
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // decoration: BoxDecoration(
        //   color: TColor.gray,
        //   borderRadius: BorderRadius.circular(10),
        //   boxShadow: [
        //     BoxShadow(
        //       color: TColor.lightGray,
        //       blurRadius: 5,
        //       offset: Offset(0, 2),
        //     ),
        //   ],
        // ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
        
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [TColor.primaryColor2.withOpacity(0.9), TColor.secondaryColor1.withOpacity(0.5)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: TColor.lightGray,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ]
                  ,
                  borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.center,
              child: Image.asset(
                nObj["image"].toString(),
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                nObj["title"].toString(),
                style: TextStyle(color: TColor.black, fontSize: 12),
              ),
            ),
            Padding(padding: 
            const EdgeInsets.all(0),
            child: Text(
              nObj["value"].toString(),
              style: TextStyle(color: TColor.black, fontSize: 10),
            ),
            ),
            
          ],
        ));
  }
}
