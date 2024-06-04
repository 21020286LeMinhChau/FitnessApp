import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/request_status.dart';
import '../model/notification.dart';

class NotificationService{
  static const collectionNotification = "notification";

  Future<Map<String, dynamic>> createNotification(AppNotification notification) async {
    try {
      var notificationCreate = await FirebaseFirestore.instance
          .collection(collectionNotification)
          .add(notification.toMap());
      return {
        'status': RequestStatus.request201Created,
        'data': notificationCreate.id,
      };
    } catch (e) {
      return {
        'status': RequestStatus.request500InternalServerError,
        'data': e.toString(),
      };
    }
  }

  Future<List<AppNotification>> findNotificationsByUserId(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection(collectionNotification)
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => AppNotification.fromSnapshot(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> deleteNotification(String notificationId) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionNotification)
          .doc(notificationId)
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

  Future<Map<String, dynamic>> updateNotification(String notificationId, Map<String, dynamic> updatedData) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionNotification)
          .doc(notificationId)
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