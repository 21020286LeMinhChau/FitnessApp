import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:fitness/common/common.dart';
import 'package:flutter/material.dart';

import '../common/color_extension.dart';

// import 'package:flutter_switch/flutter_switch.dart';
class TodaySleepSchedule extends StatefulWidget {
  final Map sObj;

  const TodaySleepSchedule({super.key, required this.sObj});
  @override
  State<TodaySleepSchedule> createState() => _TodaySleepScheduleState();
}

class _TodaySleepScheduleState extends State<TodaySleepSchedule> {
  bool isOn = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: TColor.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              widget.sObj["image"].toString(),
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.sObj["name"].toString()}, ${getStringDateToOtherFormate(widget.sObj["time"].toString(), outFormatStr: "h:mm aa")}",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                widget.sObj["duration"].toString(),
                style: TextStyle(
                  color: TColor.gray,
                  fontSize: 12,
                ),
              ),
            ],
          )),

          // on off switch
          CustomAnimatedToggleSwitch<bool>(
              current: isOn,
              values: const [true, false],
              dif: 0.0,
              indicatorSize: const Size.square(30.0),
              animationDuration: const Duration(milliseconds: 200),
              animationCurve: Curves.linear,
              onChanged: (b) => setState(() => isOn = b),
              iconBuilder: (context, local, global) {
                return const SizedBox();
              },
              defaultCursor: SystemMouseCursors.click,
              onTap: () => setState(() => isOn = !isOn),
              iconsTappable: false,
              wrapperBuilder: (context, global, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        left: 10.0,
                        right: 10.0,
                        height: 30.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors:  isOn ?TColor.primaryG: TColor.secondaryG,
                              ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                          ),
                        )),
                    child,
                  ],
                );
              },
              foregroundIndicatorBuilder: (context, global) {
                return SizedBox.fromSize(
                  size: const Size(10, 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: TColor.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0.05,
                            blurRadius: 1.1,
                            offset: Offset(0.0, 0.8))
                      ],
                    ),
)
                );
              }),                           

          
        ]));
  }
}
