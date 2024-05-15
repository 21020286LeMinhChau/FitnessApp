import 'package:fitness/model/setExercise.dart';
import 'package:fitness/model/workout_playlist_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/service/workout_playlist.dart';
import 'package:get/get.dart';

class SetPlaylistService extends GetxController {
  static SetPlaylistService get to => Get.find();
  final _db = FirebaseFirestore.instance;
  static const collectionPlaylist = "setExercise";

  /// Get all workout playlist
  Future<List<SetExercisetModel>> getSetPlaylist() async {
    try {
      final snapshot = await _db.collection('setExercise').get();
      final list = snapshot.docs
          .map((doc) => SetExercisetModel.fromSnapshot(doc))
          .toList();
      print(list.length);

      return list;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<SetExercisetModel> getSetPlaylistById(String id) async {
    try {
      final docSnapshot = await _db.collection('setExercise').doc(id).get();
      if (docSnapshot.exists) {
        return SetExercisetModel.fromSnapshot(docSnapshot);
      } else {
        throw 'No document found with the given id';
      }
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<SetExercisetModel>> getSetPlayListByWorkOutPlayListId(
      String playListId) async {
    try {
      print(2);

      WorkoutPlaylistModel workoutPlayList =
          await WorkoutPlaylistService.to.getWorkoutPlaylistById(playListId);
      print(workoutPlayList.listSetId.length);
      List<SetExercisetModel> listSetExercise = [];
      for (String setId in workoutPlayList.listSetId) {
        SetExercisetModel set = await getSetPlaylistById(setId);
        listSetExercise.add(set);
      }
      return listSetExercise;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
