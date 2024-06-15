import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/request_status.dart';
import '../model/workout.dart';

class WorkoutService {
  static const collectionWorkout = "workout";

  Future<Map<String, dynamic>> createWorkout(Workout workout) async {
    try {
      var workoutCreate = await FirebaseFirestore.instance
          .collection(collectionWorkout)
          .add(workout.newWorkout());
      return {
        'status': RequestStatus.request201Created,
        'data': workoutCreate.id,
      };
    } catch (e) {
      return {
        'status': RequestStatus.request500InternalServerError,
        'data': e.toString(),
      };
    }
  }

  Future<List<Workout>> findWorkoutsByUserId(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection(collectionWorkout)
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => Workout.fromSnapshot(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> deleteWorkout(String workoutId) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionWorkout)
          .doc(workoutId)
          .delete();
      return {
        'status': RequestStatus.request204NoContent,
      };
    } catch (e) {
      return {
        'status': RequestStatus.request500InternalServerError,
        'data': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> updateWorkout(String workoutId, Map<String, dynamic> updatedData) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionWorkout)
          .doc(workoutId)
          .update(updatedData);
      return {
        'status': RequestStatus.request200Ok,
      };
    } catch (e) {
      return {
        'status': RequestStatus.request500InternalServerError,
        'data': e.toString(),
      };
    }
  }
}
