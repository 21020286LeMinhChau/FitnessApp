import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  String? id;
  String? name;
  String? userId;
  String? image;
  int? kcal;
  int? time;
  double? progress;
  DateTime? date;

  Workout({
    this.id,
    this.name,
    this.userId,
    this.image,
    this.kcal,
    this.time,
    this.progress,
    this.date,
  });

  factory Workout.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Workout(
      id: snapshot.id,
      name: data['name'],
      userId: data['userId'],
      image: data['image'],
      kcal: data['kcal'],
      time: data['time'],
      progress: data['progress'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
      'image': image,
      'kcal': kcal,
      'time': time,
      'progress': progress,
      'date': date,
    };
  }

  Map<String, dynamic> newWorkout() {
    return {
      'name': name,
      'userId': userId,
      'image': image,
      'kcal': kcal,
      'time': time,
      'progress': progress,
      'date': date,
    };
  }
}
