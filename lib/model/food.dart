class Food {
  String? id;
  String name;
  String? image;
  String? time;
  String? kcal;
  String? size;
  String? b_image;
  String? schedule_time;
  String? description;
  List<Nutrition> nutrition = [];
  List<Ingredients> ingredients = [];
  List<StepToMake> stepToMake = [];
  Food({
    required this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "image": image,
      "time": time,
      "kcal": kcal,
      "size": size,
      "b_image": b_image,
      "schedule_time": schedule_time,
      "description": description,
      "nutrition": nutrition.map((e) => e.toMap()).toList(),
      "ingredients": ingredients.map((e) => e.toMap()).toList(),
      "stepToMake": stepToMake.map((e) => e.toMap()).toList(),
    };
  }
  
}

class Nutrition {
  String? id;
  String? title;
  String? image;
  String? unit_name;
  int? value;
  int? max_value;
  Map toMap() => {
        "title": title,
        "image": image,
        "unit_name": unit_name,
        "value": value,
        "max_value": max_value,
      };
}

class Ingredients {
  String? id;
  String? food_id;
  String? title;
  String? image;
  String? unit_name;
  int? value;
  Map toMap() => {
        "title": title,
        "image": image,
        "unit_name": unit_name,
        "value": value,
      };
}
class StepToMake {
  String? id;
  String? no;
  String? detail;
  String? food_id;
  Map toMap() => {
        "no": no,
        "detail": detail,
      };
}