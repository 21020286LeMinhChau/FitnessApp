// TODO Implement this library.
import 'dart:math';

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

  Future<List<ExerciselModel>> fetchExercise(String id) async {
    ExerciseService exerciseService = ExerciseService();
    List<ExerciselModel> listExercise =
        await exerciseService.getExcercisePlayListBySetPlayListId(id);

    exerciseArr = listExercise
        .map((exercise) => {
              "image": exercise.image,
              "title": exercise.title,
            })
        .toList();

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
          future: fetchExercise("1"),
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
