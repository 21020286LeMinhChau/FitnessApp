import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciselModel {
  String id;
  String title;
  String image;
  int calories;
  String description;
  List<String> listStepId;
  ExerciselModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.calories,
      required this.description,
      required this.listStepId});

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
      "calories": calories,
      "description": description,
      "listStepId": listStepId,
    };
  }

  static ExerciselModel empty() {
    return ExerciselModel(
      id: '',
      title: '',
      image: '',
      calories: 0,
      description: '',
      listStepId: [],
    );
  }

  factory ExerciselModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.exists) {
      final data = document.data()!;
      return ExerciselModel(
        id: document.id,
        title: data['title'] ?? '',
        image: data['image'] ?? '',
        calories: data['calories'] ?? 0,
        description: data['description'] ?? '',
        listStepId: List<String>.from(data['listStepId'] ?? []),
      );
    } else {
      return ExerciselModel.empty();
    }
  }
}
