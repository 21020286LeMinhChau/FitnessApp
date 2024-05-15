import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/model/excersise.dart';
import 'package:fitness/model/setExercise.dart';
import 'package:fitness/model/workout_playlist_model.dart';
import 'package:fitness/service/setExercise_playlist.dart';
import 'package:fitness/service/workout_playlist.dart';
import 'package:get/get.dart';

class ExerciseService extends GetxController {
  final _db = FirebaseFirestore.instance;
  String collectionExercise = "exerciseWorkout";

  Future<List<ExerciselModel>> getExerciseWorkout() async {
    try {
      final snapshot = await _db.collection(collectionExercise).get();
      final list =
          snapshot.docs.map((doc) => ExerciselModel.fromSnapshot(doc)).toList();
      print(list.length);
      return list;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<ExerciselModel> getExerciseById(String id) async {
    try {
      final docSnapshot =
          await _db.collection(collectionExercise).doc(id).get();
      if (docSnapshot.exists) {
        return ExerciselModel.fromSnapshot(docSnapshot);
      } else {
        throw 'No document found with the given id';
      }
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ExerciselModel>> getExcercisePlayListBySetPlayListId(
      String setId) async {
    try {
      print(2);

      SetExercisetModel setPlaylist =
          await SetPlaylistService.to.getSetPlaylistById(setId);
      print(setPlaylist.listExerciseId.length);
      List<ExerciselModel> listExercise = [];
      for (String exerciselId in setPlaylist.listExerciseId) {
        ExerciselModel exercise = await getExerciseById(exerciselId);
        listExercise.add(exercise);
      }

      return listExercise;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
