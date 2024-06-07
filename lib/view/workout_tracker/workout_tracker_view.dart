import 'package:fitness/common/color_extension.dart';
import 'package:fitness/controller/workoutPlaylist_controller.dart';
import 'package:fitness/model/excersise.dart';
import 'package:fitness/model/tool.dart';
import 'package:fitness/model/workout_playlist_model.dart';
import 'package:fitness/service/excercise_playlist.dart';
import 'package:fitness/service/tool_playlist.dart';
import 'package:fitness/view/meal_planner/meal_planner_view.dart';
import 'package:fitness/view/workout_tracker/add_schedule_view.dart';
import 'package:fitness/view/workout_tracker/workour_detail_view.dart';
import 'package:fitness/view/workout_tracker/workoutSchedule.dart';
import 'package:fitness/view/workout_tracker/workout_schedule_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/round_button.dart';
import '../../common_widget/upcoming_workout_row.dart';
import '../../common_widget/what_train_row.dart';

import 'package:fitness/service/workout_playlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutTrackerView extends StatefulWidget {
  const WorkoutTrackerView({super.key});

  @override
  State<WorkoutTrackerView> createState() => _WorkoutTrackerViewState();
}

class _WorkoutTrackerViewState extends State<WorkoutTrackerView> {
  int displayedItemCount = 2;
  int listlength = 0;
  int listFeaturedLength = 0;
  List<Map<String, String>> exerciseArr = [];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final workoutPlaylistController = Get.put(WorkoutPlaylistController());

    Future<RxList<WorkoutPlaylistModel>>
        fetchWorkoutPlaylistController() async {
      await workoutPlaylistController.fetchWorkoutPlaylist();

      listlength = workoutPlaylistController.allWorkoutPlaylist.length;
      return Future.value(workoutPlaylistController.allWorkoutPlaylist);
    }

    Future<RxList<WorkoutPlaylistModel>>
        fetchFeaturedWorkoutPlaylistController() async {
      await workoutPlaylistController.fetchFeaturedWorkoutPlaylist();
      listFeaturedLength =
          workoutPlaylistController.featuredWorkoutPlaylist.length;
      return Future.value(workoutPlaylistController.featuredWorkoutPlaylist);
    }

    return Container(
      decoration:
          BoxDecoration(gradient: LinearGradient(colors: TColor.primaryG)),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              // pinned: true,
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
                "Workout Tracker",
                style: TextStyle(
                    color: TColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
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
                      width: 15,
                      height: 15,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              ],
            ),
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leadingWidth: 0,
              leading: const SizedBox(),
              expandedHeight: media.width * 0.5,
              flexibleSpace: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: media.width * 0.5,
                width: double.maxFinite,
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      enabled: true,
                      handleBuiltInTouches: false,
                      touchCallback:
                          (FlTouchEvent event, LineTouchResponse? response) {
                        if (response == null || response.lineBarSpots == null) {
                          return;
                        }
                        // if (event is FlTapUpEvent) {
                        //   final spotIndex =
                        //       response.lineBarSpots!.first.spotIndex;
                        //   showingTooltipOnSpots.clear();
                        //   setState(() {
                        //     showingTooltipOnSpots.add(spotIndex);
                        //   });
                        // }
                      },
                      mouseCursorResolver:
                          (FlTouchEvent event, LineTouchResponse? response) {
                        if (response == null || response.lineBarSpots == null) {
                          return SystemMouseCursors.basic;
                        }
                        return SystemMouseCursors.click;
                      },
                      getTouchedSpotIndicator:
                          (LineChartBarData barData, List<int> spotIndexes) {
                        return spotIndexes.map((index) {
                          return TouchedSpotIndicatorData(
                            FlLine(
                              color: Colors.transparent,
                            ),
                            FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) =>
                                  FlDotCirclePainter(
                                radius: 3,
                                color: Colors.white,
                                strokeWidth: 3,
                                strokeColor: TColor.secondaryColor1,
                              ),
                            ),
                          );
                        }).toList();
                      },
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: TColor.secondaryColor1,
                        tooltipRoundedRadius: 20,
                        getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                          return lineBarsSpot.map((lineBarSpot) {
                            return LineTooltipItem(
                              "${lineBarSpot.x.toInt()} mins ago",
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                    lineBarsData: lineBarsData1,
                    minY: -0.5,
                    maxY: 110,
                    titlesData: FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(),
                        topTitles: AxisTitles(),
                        bottomTitles: AxisTitles(
                          sideTitles: bottomTitles,
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: rightTitles,
                        )),
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      horizontalInterval: 25,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: TColor.white.withOpacity(0.15),
                          strokeWidth: 2,
                        );
                      },
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: TColor.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                        color: TColor.gray.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(3)),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      color: TColor.primaryColor2.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Daily Workout Schedule",
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 75,
                          height: 25,
                          child: RoundButton(
                            title: "Check",
                            type: RoundButtonType.bgGradient,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WorkoutSchedule(), // TODO: Add Schedule View
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Upcoming Workout",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            displayedItemCount = displayedItemCount == 2
                                ? listFeaturedLength
                                : 2;
                          });
                          /*   test(); */
                        },
                        child: Text(
                          displayedItemCount == 2 ? "See More" : "See Less",
                          style: TextStyle(
                              color: TColor.gray,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  FutureBuilder<List<WorkoutPlaylistModel>>(
                    future: fetchFeaturedWorkoutPlaylistController(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<WorkoutPlaylistModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // or your custom loading widget
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: displayedItemCount,
                          itemBuilder: (_, index) {
                            final playlist = snapshot.data?[index];
                            print(workoutPlaylistController.isLoading.value);
                            return UpcomingWorkoutRow(
                              workoutPlaylistItem:
                                  playlist as WorkoutPlaylistModel,
                            );
                          },
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "What Do You Want to Train",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  FutureBuilder<List<WorkoutPlaylistModel>>(
                    future: fetchWorkoutPlaylistController(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<WorkoutPlaylistModel>> snapshot) {
                      {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listlength,
                          itemBuilder: (_, index) {
                            final playlist = snapshot.data?[index];
/*                             print(workoutPlaylistController.isLoading.value);
 */
                            return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WorkoutDetailView(
                                        workoutDetailItemView:
                                            playlist as WorkoutPlaylistModel,
                                        id: playlist.id,
                                      ),
                                    ),
                                  );
                                },
                                child: WhatTrainRow(
                                  workoutPlaylistItem:
                                      playlist as WorkoutPlaylistModel,
                                ));
                          },
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: media.width * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        // lineChartBarData1_2,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: TColor.white.withOpacity(0.9),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 27),
          FlSpot(2, 45),
          FlSpot(3, 65),
          FlSpot(4, 30),
          FlSpot(5, 50),
          FlSpot(6, 75),
          FlSpot(7, 60),
        ],
      );

  // LineChartBarData get lineChartBarData1_2 => LineChartBarData(
  //       isCurved: true,
  //       color: TColor.white.withOpacity(0.5),
  //       barWidth: 2,
  //       isStrokeCapRound: true,
  //       dotData: FlDotData(show: false),
  //       belowBarData: BarAreaData(
  //         show: false,
  //       ),
  //       spots: const [
  //         FlSpot(1, 80),
  //         FlSpot(2, 50),
  //         FlSpot(3, 90),
  //         FlSpot(4, 40),
  //         FlSpot(5, 80),
  //         FlSpot(6, 35),
  //         FlSpot(7, 60),
  //       ],
  //     );

  SideTitles get rightTitles => SideTitles(
        getTitlesWidget: rightTitleWidgets,
        showTitles: true,
        interval: 20,
        reservedSize: 40,
      );

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0 cal';
        break;
      case 20:
        text = '300';
        break;
      case 40:
        text = '600';
        break;
      case 60:
        text = '900';
        break;
      case 80:
        text = '1200';
        break;
      case 100:
        text = '1500';
        break;
      default:
        return Container();
    }

    return Text(text,
        style: TextStyle(
          color: TColor.white,
          fontSize: 12,
        ),
        textAlign: TextAlign.center);
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: TColor.white,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('Sun', style: style);
        break;
      case 2:
        text = Text('Mon', style: style);
        break;
      case 3:
        text = Text('Tue', style: style);
        break;
      case 4:
        text = Text('Wed', style: style);
        break;
      case 5:
        text = Text('Thu', style: style);
        break;
      case 6:
        text = Text('Fri', style: style);
        break;
      case 7:
        text = Text('Sat', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }
}
