import 'package:fitness/model/workout_playlist_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WorkoutPlaylistService extends GetxController {
  static WorkoutPlaylistService get to => Get.find();
  final _db = FirebaseFirestore.instance;
  static const collectionPlaylist = "workoutPlaylist";

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

  Future<WorkoutPlaylistModel> getWorkoutPlaylistById(String id) async {
    try {
      final docSnapshot = await _db.collection('workoutPlaylist').doc(id).get();
      if (docSnapshot.exists) {
        return WorkoutPlaylistModel.fromSnapshot(docSnapshot);
      } else {
        throw 'No document found with the given id';
      }
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
