import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification{
  String? id;
  String? image;
  String? message;
  String? userId;
  String? type;
  DateTime? time;
  bool? state;

  AppNotification({
    this.id,
    this.message,
    this.image,
    this.userId,
    this.type,
    this.time,
    this.state,
  });


  factory AppNotification.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return AppNotification(
      id: snapshot.id,
        message: data['message'],
        image: data['image'],
        userId: data['userId'],
        type: data['type'],
        time: data['time'].toDate(),
        state: data['state']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'image':image,
      'userId': userId,
      'type': type,
      'time': time,
      'state': state,
    };
  }

  Map<String, dynamic> newNotification() {
    return {
      'message': message,
      'image':image,
      'userId': userId,
      'type': type,
      'time': time,
      'state': state,
    };
  }
}