import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciselModel {
  String id;

  String title;
  String image;
  ExerciselModel({required this.id, required this.title, required this.image});

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
    };
  }

  static ExerciselModel empty() {
    return ExerciselModel(
      id: '',
      title: '',
      image: '',
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
      );
    } else {
      return ExerciselModel.empty();
    }
  }
}
