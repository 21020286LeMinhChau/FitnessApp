import 'package:cloud_firestore/cloud_firestore.dart';

class ToolModel {
  String id;
  String playlistId;
  String name;
  String image;
  ToolModel(
      {required this.id,
      required this.playlistId,
      required this.name,
      required this.image});

  Map<String, dynamic> toJson() {
    return {"name": name, "image": image, "playlistId": playlistId};
  }

  static ToolModel empty() {
    return ToolModel(
      id: '',
      playlistId: '',
      name: '',
      image: '',
    );
  }

  factory ToolModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.exists) {
      final data = document.data()!;
      return ToolModel(
        id: document.id,
        playlistId: data['playlistId'] ?? '',
        name: data['name'] ?? '',
        image: data['image'] ?? '',
      );
    } else {
      return ToolModel.empty();
    }
  }
}
