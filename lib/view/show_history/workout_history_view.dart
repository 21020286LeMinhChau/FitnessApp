import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../common/color_extension.dart';
import '../../common/request_status.dart';
import '../../common_widget/workout_row.dart';
import '../../model/workout.dart';
import '../../service/workout_service.dart';
import '../home/finished_workout_view.dart';

class WorkoutHistoryView extends StatefulWidget {
  final String userId;
  const WorkoutHistoryView({super.key, required this.userId});

  @override
  State<WorkoutHistoryView> createState() => _WorkoutHistoryViewState();
}

class _WorkoutHistoryViewState extends State<WorkoutHistoryView> {
  List<Workout> workoutArr = [];
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    fetchWorkouts();
  }

  Future<void> fetchWorkouts() async {
    WorkoutService workoutService = WorkoutService();
    List<Workout> workouts =
    (await workoutService.findWorkoutsByUserId(widget.userId)).cast<Workout>();
    workouts.sort((a, b) {
      if (a.date != null && b.date != null) {
        return b.date!.compareTo(a.date!);
      } else {
        if (a.date == null && b.date != null) {
          return 1;
        } else if (a.date != null && b.date == null) {
          return -1;
        } else {
          return 0;
        }
      }
    });
    setState(() {
      workoutArr = workouts;
      logger.d(workoutArr.length);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/black_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Workout History",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/img/more_btn.png",
                width: 12,
                height: 12,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: workoutArr.length,
        itemBuilder: (context, index) {
          var wObj = workoutArr[index].toMap();
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FinishedWorkoutView(),
                ),
              );
            },
            child: WorkoutRow(wObj: wObj),
          );
        },
      ),
    );
  }
}
