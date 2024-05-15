// TODO Implement this library.import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/icon_title_next_row.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/model/excersise.dart';
import 'package:fitness/model/setExercise.dart';
import 'package:fitness/model/tool.dart';
import 'package:fitness/model/workout_playlist_model.dart';
import 'package:fitness/service/excercise_playlist.dart';
import 'package:fitness/service/setExercise_playlist.dart';
import 'package:fitness/view/workout_tracker/exercises_stpe_details.dart';
import 'package:fitness/view/workout_tracker/workout_schedule_view.dart';
import 'package:flutter/material.dart';
import '../../common/color_extension.dart';

import '../../common_widget/exercises_set_section.dart';
import '../../service/tool_playlist.dart';

class WorkoutDetailView extends StatefulWidget {
/*   final Map dObj;
 */
  final WorkoutPlaylistModel workoutDetailItemView;
  final String id;
  WorkoutDetailView({required this.workoutDetailItemView, required this.id});
  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView> {
  @override
  void initState() {
    super.initState();
    test(widget.id);
  }

  List<Map<String, String>> youArr = [];
  List<Map<String, String>> setArr = [];
  int count = 0;
  test(String id) async {
    ToolService toolService = ToolService();
    List<ToolModel> listTool =
        await toolService.getToolPlayListByWorkOutPlayListId(id);

    youArr = listTool
        .map((tool) => {
              "image": tool.image,
              "title": tool.name,
            })
        .toList();
    count = youArr.length;
  }
/* 
  fetchExercise(String id) async {
    ExerciseService exerciseService = ExerciseService();
    List<ExerciselModel> listExercise =
        await exerciseService.getExcercisePlayListByWorkOutPlayListId(id);
    exercisesArr = listExercise
        .map((exercise) => {
              "image": exercise.image,
              "title": exercise.title,
            })
        .toList();
  } */

  Future<List<SetExercisetModel>> fetchSetPlaylist(String id) async {
    SetPlaylistService setPlaylistService = SetPlaylistService();
    List<SetExercisetModel> listSet =
        await setPlaylistService.getSetPlayListByWorkOutPlayListId(id);
    setArr = listSet
        .map((set) => {
              "title": set.name,
            })
        .toList();
    return listSet;
    // Add this line to return the list of exercises
  }

  @override
  Widget build(BuildContext context) {
/*     test();
 */
    var media = MediaQuery.of(context).size;
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
              leading: Container(),
              expandedHeight: media.width * 0.5,
              flexibleSpace: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/img/detail_top.png",
                  width: media.width * 0.75,
                  height: media.width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: TColor.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                SingleChildScrollView(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.workoutDetailItemView.title,
                                  style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "${widget.workoutDetailItemView.exercise} exercises | ${widget.workoutDetailItemView.long} | 320 Calories Burn",
                                  style: TextStyle(
                                      color: TColor.gray, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Image.asset(
                              "assets/img/fav.png",
                              width: 15,
                              height: 15,
                              fit: BoxFit.contain,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      IconTitleNextRow(
                          icon: "assets/img/time.png",
                          title: "Schedule Workout",
                          time: "5/27, 09:00 AM",
                          color: TColor.primaryColor2.withOpacity(0.3),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WorkoutScheduleView()));
                          }),
                      SizedBox(
                        height: media.width * 0.02,
                      ),
                      IconTitleNextRow(
                          icon: "assets/img/difficulity.png",
                          title: "Difficulity",
                          time: "Beginner",
                          color: TColor.secondaryColor2.withOpacity(0.3),
                          onPressed: () {}),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "You'll Need",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          /*  TextButton(
                            onPressed: () async {
                              var result = await test(widget.id);
                              setState(() {
                                count = result
                                    .length; // assuming test() returns a list
                              });
                            },
                            child: Text(
                              "${count} Items",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 12),
                            ),
                          ) */
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.5,
                        child: FutureBuilder(
                          future: test(widget.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.error != null) {
                              return Center(child: Text('An error occurred!'));
                            } else {
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: count,
                                itemBuilder: (context, index) {
                                  var yObj = youArr[index] as Map? ?? {};
                                  return Container(
                                    margin: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: media.width * 0.35,
                                          width: media.width * 0.35,
                                          decoration: BoxDecoration(
                                            color: TColor.lightGray,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            yObj["image"].toString(),
                                            width: media.width * 0.8,
                                            height: media.width * 0.8,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            yObj["title"].toString(),
                                            style: TextStyle(
                                              color: TColor.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Exercises",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "${youArr.length} Sets",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      FutureBuilder(
                        future: fetchSetPlaylist(widget.id),
                        builder: (context,
                            AsyncSnapshot<List<SetExercisetModel>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.error != null) {
                            return Center(child: Text('An error occurred!'));
                          } else {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                final setPlaylist = snapshot.data?[index];
                                return ExercisesSetSection(
                                  setItem: setPlaylist as SetExercisetModel,
                                  onPressed: (obj) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ExercisesStepDetails(
                                          eObj: obj,
                                        ),
                                      ),
                                    );
                                  },
                                );
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
                SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundButton(title: "Start Workout", onPressed: () {})
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
