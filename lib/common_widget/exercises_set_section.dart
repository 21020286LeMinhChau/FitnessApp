// TODO Implement this library.
import 'package:fitness/model/excersise.dart';
import 'package:fitness/model/setExercise.dart';
import 'package:fitness/service/excercise_playlist.dart';
import 'package:flutter/material.dart';

import '../common/color_extension.dart';
import 'exercises_row.dart';

List<Map<String, String>> exerciseArr = [];

class ExercisesSetSection extends StatelessWidget {
  final SetExercisetModel setItem;
  final Function(Map obj) onPressed;

  const ExercisesSetSection({required this.onPressed, required this.setItem});

  

  /* Future<List<ExerciselModel>> fetchExercise(String id) async {
    ExerciseService exerciseService = ExerciseService();
    print("buoc 1");

    List<ExerciselModel> listExercise =
        await exerciseService.getExercisePlayListBySetPlayListId("2");
    print("buoc 2000");

    exerciseArr = listExercise
        .map((exercise) => {
              "image": exercise.image,
              "title": exercise.title,
            })
        .toList();
    print(exerciseArr);
    print("buoc 3");

    return listExercise;
  } */
  Future<List<ExerciselModel>> fetchExercise2(String id) async {
    ExerciseService exerciseService = ExerciseService();
    print("buoc 1");

    List<ExerciselModel> listExercise =
        await exerciseService.getExercisePlayListByWorkOutPlayListId("1");
    print("buoc 2000");

    exerciseArr = listExercise
        .map((exercise) => {
              "image": exercise.image,
              "title": exercise.title,
            })
        .toList();
    print(exerciseArr);
    print("buoc 3");

    return listExercise;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Set " + setItem.name,
          style: TextStyle(
              color: TColor.black, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 8,
        ),
        FutureBuilder(
          future: fetchExercise2("1"),
          builder: (context, AsyncSnapshot<List<ExerciselModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return Center(child: Text('An error occurred!'));
            } else {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  final exercise = snapshot.data?[index];
                  return ExercisesRow(
                    exerciselItem: exercise as ExerciselModel,
                    onPressed: () {
/*                   onPressed(eObj);
 */
                    },
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
