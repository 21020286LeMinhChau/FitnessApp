import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String? id;
  String? userId;
  String? name;
  String? image;
  DateTime? date;
  String? type;
  String? value;

  Activity({
    this.id,
    this.userId,
    this.name,
    this.image,
    this.date,
    this.type,
    this.value,
  });

  factory Activity.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Activity(
      id: snapshot.id,
      userId: data['userId'],
      name: data['name'],
      image: data['image'],
      date: (data['date'] as Timestamp).toDate(),
      type: data['type'],
      value: data['value'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'image': image,
      'date': date,
      'type': type,
      'value': value,
    };
  }

  Map<String, dynamic> newActivity() {
    return {
      'userId': userId,
      'name': name,
      'image': image,
      'date': date,
      'type': type,
      'value': value,
    };
  }
}
