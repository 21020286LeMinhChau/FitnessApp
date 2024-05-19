import 'package:fitness/model/food.dart';

class Meal {
  String ?id;
  String category;
  DateTime ?date;
  List<Food> food = [];
  Meal({
    required this.category,
  });
  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "date": date,
      "food": food.map((e) => e.toMap()).toList(),
    };
  }
}

