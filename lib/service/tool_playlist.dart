import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/model/tool.dart';
import 'package:fitness/model/workout_playlist_model.dart';
import 'package:fitness/service/workout_playlist.dart';
import 'package:get/get.dart';

class ToolService extends GetxController {
  // static ToolService get to => Get.find();
  final _db = FirebaseFirestore.instance;
  String collectionTool = "toolWorkout";

  Future<List<ToolModel>> getToolWorkout() async {
    try {
      final snapshot = await _db.collection(collectionTool).get();
      final list =
          snapshot.docs.map((doc) => ToolModel.fromSnapshot(doc)).toList();
      print(list.length);
      return list;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<ToolModel> getToolById(String id) async {
    try {
      final docSnapshot = await _db.collection(collectionTool).doc(id).get();
      if (docSnapshot.exists) {
        return ToolModel.fromSnapshot(docSnapshot);
      } else {
        throw 'No document found with the given id';
      }
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ToolModel>> getToolPlayListByWorkOutPlayListId(
      String playListId) async {
    try {
      print(2);

      WorkoutPlaylistModel workoutPlayList =
          await WorkoutPlaylistService.to.getWorkoutPlaylistById(playListId);
      print(workoutPlayList.listToolId.length);
      List<ToolModel> listTool = [];
      for (String toolId in workoutPlayList.listToolId) {
        ToolModel tool = await getToolById(toolId);
        listTool.add(tool);
      }

      return listTool;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
