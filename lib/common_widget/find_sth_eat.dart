import 'package:fitness/common_widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/color_extension.dart';

class FindSthToEat extends StatelessWidget {
  final Map fObj;
  const FindSthToEat({super.key, required this.fObj});


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      width: media.width * 0.5,
      height: media.width * 0.4,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          TColor.primaryColor2.withOpacity(0.3),
          TColor.primaryColor1.withOpacity(0.3)
        ]),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(75),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                fObj["image"].toString(),
                width: media.width * 0.3,
                height: media.width * 0.25,
                fit: BoxFit.contain,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text(
                        fObj["name"].toString(),
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text(
                        fObj["number"].toString(),
                        style: TextStyle(
                            color: TColor.gray,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 90,
                height: 25,
                child: RoundButton(
                  title: "Select",
                  onPressed: () {},
                  type: RoundButtonType.bgGradient,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ],
      ),
    );
    
  }
}
