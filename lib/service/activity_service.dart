import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/request_status.dart';
import '../model/activity.dart';

class ActivityService {
  static const collectionActivity = "activity";

  Future<Map<String, dynamic>> createActivity(Activity activity) async {
    try {
      var activityCreate = await FirebaseFirestore.instance
          .collection(collectionActivity)
          .add(activity.newActivity());
      return {
        'status': RequestStatus.request201Created,
        'data': activityCreate.id,
      };
    } catch (e) {
      return {
        'status': RequestStatus.request500InternalServerError,
        'data': e.toString(),
      };
    }
  }

  Future<List<Activity>> findActivitiesByUserId(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection(collectionActivity)
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => Activity.fromSnapshot(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> deleteActivity(String activityId) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionActivity)
          .doc(activityId)
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

  Future<Map<String, dynamic>> updateActivity(String activityId, Map<String, dynamic> updatedData) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionActivity)
          .doc(activityId)
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
