import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../common/color_extension.dart';
import '../../common/request_status.dart';
import '../../common_widget/latest_activity_row.dart';
import '../../model/activity.dart';
import '../../service/activity_service.dart';

class ActivityHistoryView extends StatefulWidget {
  final String userId;
  const ActivityHistoryView({super.key, required this.userId});

  @override
  State<ActivityHistoryView> createState() => _ActivityHistoryViewState();
}

class _ActivityHistoryViewState extends State<ActivityHistoryView> {
  List<Activity> activityArr = [];
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    // _createList();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    ActivityService activityService = ActivityService();
    List<Activity> activitys =
    (await activityService.findActivitiesByUserId(widget.userId)).cast<Activity>();
    activitys.sort((a, b) {
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
      activityArr = activitys;
      logger.d(activityArr.length);
    });
  }

  Future<void> _createList() async {
    ActivityService activityService = ActivityService();
    for (var activityData in createList) {
      Activity newActivity = Activity(
        name: activityData['name'],
        type: activityData['type'],
        value: activityData['value'],
        image: activityData['image'],
        userId: widget.userId, // Thay đổi userId tùy theo yêu cầu của bạn
        date: DateTime.now(),
      );
      var result = await activityService.createActivity(newActivity);
      print(result);
    }
  }

  List<Map<String, dynamic>> createList = [
    {
      "name": "Drinking 300ml Water",
      "image": "assets/img/drinking.png",
      "date": DateTime.now(),
      "type": "drinking",
      "value": "300ml"
    },
    {
      "name": "Eating Breakfast (Omelette and Toast)",
      "image": "assets/img/eating.png",
      "date": DateTime.now(),
      "type": "eating",
      "value": "Omelette and Toast"
    },
    {
      "name": "Sleeping (8 hours)",
      "image": "assets/img/sleeping.png",
      "date": DateTime.now(),
      "type": "sleeping",
      "value": "8 hours"
    },
    {
      "name": "Morning Walk (5 km)",
      "image": "assets/img/foot_steps.png",
      "date": DateTime.now(),
      "type": "foot steps",
      "value": "5 km"
    },
    {
      "name": "Gym Workout (1 hour)",
      "image": "assets/img/exercise.png",
      "date": DateTime.now(),
      "type": "exercise",
      "value": "1 hour"
    },
    {
      "name": "Drinking Coffee (Black Coffee)",
      "image": "assets/img/drinking.png",
      "date": DateTime.now(),
      "type": "drinking",
      "value": "Black Coffee"
    },
    {
      "name": "Eating Lunch (Sandwich and Salad)",
      "image": "assets/img/eating.png",
      "date": DateTime.now(),
      "type": "eating",
      "value": "Sandwich and Salad"
    },
    {
      "name": "Night Sleep (7 hours)",
      "image": "assets/img/sleeping.png",
      "date": DateTime.now(),
      "type": "sleeping",
      "value": "7 hours"
    },
    {
      "name": "Evening Walk (3 km)",
      "image": "assets/img/foot_steps.png",
      "date": DateTime.now(),
      "type": "foot steps",
      "value": "3 km"
    },
    {
      "name": "Yoga Session (1 hour)",
      "image": "assets/img/exercise.png",
      "date": DateTime.now(),
      "type": "exercise",
      "value": "1 hour"
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
          "Activity History",
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
        itemCount: activityArr.length,
        itemBuilder: (context, index) {
          var wObj = activityArr[index].toMap();
          return InkWell(
            onTap: () {},
            child: LatestActivityRow(wObj: wObj),
          );
        },
      ),
    );
  }
}
