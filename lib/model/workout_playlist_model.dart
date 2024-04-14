import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutPlaylistModel {
  String id;
  String title;
  String time;
  String image;
  String parentId;
  bool isFeatured;
  WorkoutPlaylistModel(
      {required this.id,
      required this.title,
      required this.time,
      required this.image,
      required this.isFeatured,
      this.parentId = ""});

  // Convert model to Json stucture so that you can store data in Firebase Firestore
  Map<String, dynamic> toJson() {
    return {"title": title, "time": time, "image": image, "parentId": parentId};
  }

  static WorkoutPlaylistModel empty() {
    return WorkoutPlaylistModel(
        id: '', title: '', time: '', image: '', isFeatured: false);
  }
  // Map Json oriented document snapshot from Firebase to model

  factory WorkoutPlaylistModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.exists) {
      // Check if the document exists
      final data = document.data()!;

      // Map Json record to the model
      return WorkoutPlaylistModel(
        id: document.id,
        title: data['title'] ?? '', // Ensure the title is not null
        time: data['time'] ?? '',
        image: data['image'] ?? '',
        parentId: data['parentId'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
      );
    } else {
      // If the document doesn't exist, return an empty model
      return WorkoutPlaylistModel.empty();
    }
  }
}
