import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SetExercisetModel {
  String id;
  String name;

  List<String> listExerciseId;
  SetExercisetModel(
      {required this.id, required this.name, required this.listExerciseId});

  // Convert model to Json stucture so that you can store data in Firebase Firestore
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "exercisePlaylistId": listExerciseId,
    };
  }

  static SetExercisetModel empty() {
    return SetExercisetModel(
      id: '',
      name: '',
      listExerciseId: [],
    );
  }
  // Map Json oriented document snapshot from Firebase to model

  factory SetExercisetModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.exists) {
      // Check if the document exists
      final data = document.data()!;

      // Map Json record to the model
      return SetExercisetModel(
          id: document.id,
          name: data['name'] ?? '',
          listExerciseId: List<String>.from(
            data['exercisePlaylistId'] ?? [],
          ));
    } else {
      // If the document doesn't exist, return an empty model
      return SetExercisetModel.empty();
    }
  }
}
