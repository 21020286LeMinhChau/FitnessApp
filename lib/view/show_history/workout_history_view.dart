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
    // _createList();
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

  Future<void> _createList() async {
    WorkoutService workoutService = WorkoutService();
    for (var workoutData in createList) {
      Workout newWorkout = Workout(
        name: workoutData['name'],
        image: workoutData['image'],
        kcal: workoutData['kcal'],
        time: workoutData['time'],
        progress: workoutData['progress'],
        userId: widget.userId, // Thay đổi userId tùy theo yêu cầu của bạn
        date: DateTime.now(),
      );
      var result = await workoutService.createWorkout(newWorkout);
      print(result);
    }
  }

  List<Map<String, dynamic>> createList = [
    {
      "name": "Full Body Workout",
      "image": "assets/img/FullBodyWorkout.png",
      "kcal": 180,
      "time": 20,
      "progress": 0.3,
      "date": DateTime.parse("2023-06-01T10:00:00")
    },
    {
      "name": "Lower Body Workout",
      "image": "assets/img/LowerBodyWorkout.png",
      "kcal": 200,
      "time": 30,
      "progress": 0.4,
      "date": DateTime.parse("2023-06-02T10:00:00")
    },
    {
      "name": "Ab Workout",
      "image": "assets/img/AbWorkout.png",
      "kcal": 300,
      "time": 40,
      "progress": 0.7,
      "date": DateTime.parse("2023-06-03T10:00:00")
    },
    {
      "name": "Upper Body Workout",
      "image": "assets/img/UpperBodyWorkout.png",
      "kcal": 250,
      "time": 35,
      "progress": 0.5,
      "date": DateTime.parse("2023-06-04T10:00:00")
    },
    {
      "name": "Cardio Workout",
      "image": "assets/img/CardioWorkout.png",
      "kcal": 350,
      "time": 45,
      "progress": 0.6,
      "date": DateTime.parse("2023-06-05T10:00:00")
    },
    {
      "name": "HIIT Workout",
      "image": "assets/img/HIITWorkout.png",
      "kcal": 400,
      "time": 50,
      "progress": 0.8,
      "date": DateTime.parse("2023-06-06T10:00:00")
    },
    {
      "name": "Yoga Session",
      "image": "assets/img/yoga.png",
      "kcal": 100,
      "time": 60,
      "progress": 0.9,
      "date": DateTime.parse("2023-06-07T10:00:00")
    },
    {
      "name": "Pilates Workout",
      "image": "assets/img/PilatesWorkout.png",
      "kcal": 150,
      "time": 25,
      "progress": 0.4,
      "date": DateTime.parse("2023-06-08T10:00:00")
    },
    {
      "name": "Flexibility Workout",
      "image": "assets/img/FlexibilityWorkout.png",
      "kcal": 120,
      "time": 30,
      "progress": 0.5,
      "date": DateTime.parse("2023-06-10T10:00:00")
    },
  ];




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
