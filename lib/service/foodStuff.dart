import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/common/request_status.dart';
import 'package:fitness/model/food.dart';
class FoodStuff {
  Future getFoodByName(String name) async {
    try {
      var foodCreate = await FirebaseFirestore.instance
          .collection('Food')
          .where('name', isEqualTo: "Blueberry Pancake")
          .get();
      return {
        'status': RequestStatus.request201Created,
        'data': foodCreate.docs.first.data(),
      };
    } catch (e) {
      return RequestStatus.request500InternalServerError;
    }
  }
  Future getFoodById(String id) async {
    try {
      var foodCreate = await FirebaseFirestore.instance
          .collection('Food')
          .doc(id)
          .get();
      return {
        'status': RequestStatus.request201Created,
        'data': foodCreate.data(),
      };
    } catch (e) {
      return RequestStatus.request500InternalServerError;
    }
  }
  Future getFoodByCategory(String category) async {
    try {
      var foodCreate = await FirebaseFirestore.instance
          .collection('Food')
          .where('category', isEqualTo: category)
          .get();
      return {
        'status': RequestStatus.request201Created,
        'data': foodCreate.docs.map((e) => e.data()).toList(),
      };
    } catch (e) {
      return RequestStatus.request500InternalServerError;
    }
  }
  Future getFoodIdByName(String name) async {
    try {
      var foodCreate = await FirebaseFirestore.instance
          .collection('Food')
          .where('name', isEqualTo: name)
          .get();
      return {
        'status': RequestStatus.request201Created,
        'data': foodCreate.docs.first.id,
      };
    } catch (e) {
      return RequestStatus.request500InternalServerError;
    }
  }

}
class NutritionStuff {
  Future getNutritionByFoodId(String foodId) async {
    try {
      var nutritionCreate = await FirebaseFirestore.instance
          .collection('Nutrition')
          .where('food_id', isEqualTo: foodId)
          .get();
      return {
        'status': RequestStatus.request201Created,
        'data': nutritionCreate.docs.map((e) => e.data()).toList(),
      };
    } catch (e) {
      return RequestStatus.request500InternalServerError;
    }
  }
}