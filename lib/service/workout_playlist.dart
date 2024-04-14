import 'package:fitness/model/workout_playlist_model.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WorkoutPlaylistService extends GetxController {
  static WorkoutPlaylistService get to => Get.find();
  final _db = FirebaseFirestore.instance;

  /// Get all workout playlist
  Future<List<WorkoutPlaylistModel>> getWorkoutPlaylist() async {
    try {
      final snapshot = await _db.collection('workoutPlaylist').get();
      final list = snapshot.docs
          .map((doc) => WorkoutPlaylistModel.fromSnapshot(doc))
          .toList();
      print(list.length);

     /*  list.forEach((playlist) {
        print('Title: ${playlist.title}');
        print('Time: ${playlist.time}');
        print('Image: ${playlist.image}');
        // In ra các thuộc tính khác nếu cần
      }); */
      return list;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
