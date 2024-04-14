import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/common/color_extension.dart';
import 'package:fitness/model/workout_playlist_model.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:load_switch/load_switch.dart';

class UpcomingWorkoutRow extends StatefulWidget {
  // final Map wObj;
  final WorkoutPlaylistModel workoutPlaylistItem;

  UpcomingWorkoutRow({required this.workoutPlaylistItem});

  @override
  State<UpcomingWorkoutRow> createState() => _UpcomingWorkoutRowState();
}

class _UpcomingWorkoutRowState extends State<UpcomingWorkoutRow> {
  bool positive = false;
  Future<bool> _getFuture() async {
    await Future.delayed(const Duration(seconds: 1));
    return !positive;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: TColor.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Row(
          children: [
             ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                widget.workoutPlaylistItem.image.toString(),
                width: 50,
                height: 50,
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
                  widget.workoutPlaylistItem.title,
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.workoutPlaylistItem.time,
                  style: TextStyle(
                    color: TColor.gray,
                    fontSize: 10,
                  ),
                ),
                
              ],
            )),
            LoadSwitch(
              value: positive,
              future: _getFuture,
              style: SpinStyle.material,
              onChange: (v) {
                positive = v;
                print('Value changed to $v');
                setState(() {});
              },
              onTap: (v) {
                print('Tapping while value is $v');
              },
            ),
          ],
        ));
  }
}

class LiteRollingSwitch {}
