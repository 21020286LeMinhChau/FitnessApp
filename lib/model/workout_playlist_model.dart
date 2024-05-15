import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WorkoutPlaylistModel {
  String id;
  String title;
  String time;
  String image;
  String long;
  String parentId;
  bool isFeatured;

  int exercise;
  List<String> listToolId;
  List<String> listSetId;
  WorkoutPlaylistModel(
      {required this.id,
      required this.title,
      required this.time,
      required this.image,
      required this.isFeatured,
      required this.exercise,
      required this.long,
      this.parentId = "",
      required this.listToolId,
      required this.listSetId});

  // Convert model to Json stucture so that you can store data in Firebase Firestore
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "time": time,
      "image": image,
      "parentId": parentId,
      "long": long,
      "listToolId": listToolId,
      "listSetId": listSetId,
    };
  }

  static WorkoutPlaylistModel empty() {
    return WorkoutPlaylistModel(
      id: '',
      title: '',
      time: '',
      long: '',
      image: '',
      isFeatured: false,
      exercise: 0,
      listSetId: [],
      listToolId: [],
    );
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
          exercise: data['exercise'] ?? 0,
          long: data['long'] ?? '',
          listToolId: List<String>.from(
            data['listToolId'] ?? [],
          ),
          listSetId: List<String>.from(
            data['listSetId'] ?? [],
          ));
    } else {
      // If the document doesn't exist, return an empty model
      return WorkoutPlaylistModel.empty();
    }
  }
}
