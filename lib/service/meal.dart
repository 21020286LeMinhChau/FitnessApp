import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/common/request_status.dart';
class MealStuff {
 Future  getMealByCategory(String category) async {
    try {
      var mealCreate = await FirebaseFirestore.instance
          .collection('Meal')
          .where('category', isEqualTo: category)
          .get();
      return {
        'status': RequestStatus.request201Created,
        'data': mealCreate.docs.map((e) => e.data()).toList(),
      };
    } catch (e) {
      return RequestStatus.request500InternalServerError;
    }
  }
  Future<List<dynamic>> getMealByCategoryDay(String category, DateTime date) async {
    // compare date with only match at day/month/year
    
    try {
      DateTime start = DateTime(date.year, date.month, date.day);
      DateTime end = start.add(Duration(days: 1));
  
      var mealCreate = await FirebaseFirestore.instance
          .collection('Meal')
          .where('category', isEqualTo: category)
          .where('date', isGreaterThanOrEqualTo: start)
          .where('date', isLessThan: end)
          .get();
      return mealCreate.docs.map((e) => e.data()).toList();
    } catch (e) {
      return [];
    }
  }
  Future getMealByDate(DateTime date) async {
    try {
      var mealCreate = await FirebaseFirestore.instance
          .collection('Meal')
          .where('date', isEqualTo: date)
          .get();
      return {
        'status': RequestStatus.request201Created,
        'data': mealCreate.docs.map((e) => e.data()).toList(),
      };
    } catch (e) {
      return RequestStatus.request500InternalServerError;
    }
  }
  Future  getMealIdByDateCategory(DateTime date, String category) async {
    try {
      DateTime start = DateTime(date.year, date.month, date.day);
      DateTime end = start.add(Duration(days: 1));
      var mealCreate = await FirebaseFirestore.instance
          .collection('Meal')
          .where('date', isGreaterThanOrEqualTo: start)
          .where('date', isLessThan: end)
          .where('category', isEqualTo: category)
          .get();
      return {
        mealCreate.docs.first.id,
      };
    } catch (e) {
      print(e);
      return RequestStatus.request500InternalServerError;
    }
  }
  Future addFoodToMeal(String mealId, String foodId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Meal')
          .doc(mealId)
          .update({
        'food': FieldValue.arrayUnion([foodId])
      });
      return RequestStatus.request201Created;
    } catch (e) {
      return RequestStatus.request500InternalServerError;
    }
  }
  Future removeFoodFromMeal(String mealId, String foodId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Meal')
          .doc(mealId)
          .update({
        'food': FieldValue.arrayRemove([foodId])
      });
      return RequestStatus.request201Created;
    } catch (e) {
      return RequestStatus.request500InternalServerError;
    }
  }
  Future createMeal(String category, DateTime date) async {
    try {
      await FirebaseFirestore.instance.collection('Meal').add({
        'category': category,
        'date': date,
        'food': [],
      });
      return RequestStatus.request201Created;
    } catch (e) {
      return RequestStatus.request500InternalServerError;
    }
  }
  Future deleteMeal(String mealId) async {
    try {
      await FirebaseFirestore.instance.collection('Meal').doc(mealId).delete();
      return RequestStatus.request201Created;
    } catch (e) {
      return RequestStatus.request500InternalServerError;
    }
  }

}