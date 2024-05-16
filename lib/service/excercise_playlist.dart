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

  /* Future<List<ExerciselModel>> getExercisePlayListBySetPlayListId(
      String setId) async {
    try {
      print("buoc 2");

      SetExercisetModel setPlayList = await SetPlaylistService.to
          .getSetPlaylistById(setId); // Sử dụng tham số setId thay vì '2'
      print("buoc 3");

      print(setPlayList.listExerciseId.length);
      List<ExerciselModel> listExercise = [];
      for (String exerciseId in setPlayList.listExerciseId) {
        ExerciselModel exercise = await getExerciseById(exerciseId);
        listExercise.add(exercise);
      }
      print(listExercise);
      return listExercise;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  } */
  Future<List<ExerciselModel>> getExercisePlayListBySetPlayListId(
      String playListId) async {
    try {
      print("buoc 2");

      SetExercisetModel setPlaylist =
          await SetPlaylistService.to.getSetPlaylistById(playListId);
      print("buoc 30000");

      print(setPlaylist.listExerciseId.length);
      List<ExerciselModel> listExercise = [];
      for (String exerciseId in setPlaylist.listExerciseId) {
        ExerciselModel exercise = await getExerciseById(exerciseId);
        listExercise.add(exercise);
      }
      print(listExercise);
      return listExercise;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ExerciselModel>> getExercisePlayListByWorkOutPlayListId(
      String playListId) async {
    try {
      print("buoc 2");

      WorkoutPlaylistModel workoutPlayList =
          await WorkoutPlaylistService.to.getWorkoutPlaylistById(playListId);
      print("buoc 30000");

      print(workoutPlayList.listExerciseId.length);
      List<ExerciselModel> listExercise = [];
      for (String exerciseId in workoutPlayList.listExerciseId) {
        ExerciselModel exercise = await getExerciseById(exerciseId);
        listExercise.add(exercise);
      }
      print(listExercise);
      return listExercise;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
