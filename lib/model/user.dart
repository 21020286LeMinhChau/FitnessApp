import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String dateOfBirth;
  String firstName;
  String gender;
  String gmail;
  String height;
  String lastName;
  String id;
  String weight;

  User({
        this.id = "null",
        this.dateOfBirth = "none",
        this.firstName = "loading ..." ,
        this.lastName = "",
        this.gender = "none",
        this.height = "none",
        this.weight = "none",
        this.gmail = "none"
  });


  factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return User(
      dateOfBirth: data['dateOfBirth'] ?? '',
      firstName: data['firstName'] ?? '',
      gender: data['gender'] ?? '',
      gmail: data['gmail'] ?? '',
      height: data['height'] ?? '',
      lastName: data['lastName'] ?? '',
      id: snapshot.id,
      weight: data['weight'] ?? '',
    );
  }

  static Future<User?> getUserById(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('user').doc(userId).get();
      if (snapshot.exists) {
        return User.fromSnapshot(snapshot);
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

}