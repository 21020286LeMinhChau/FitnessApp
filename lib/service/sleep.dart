import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/common/request_status.dart';

class Sleep {
  Future getSleepByDate(DateTime date) async {
    DateTime start = DateTime(date.year, date.month, date.day);
    DateTime end = start.add(Duration(days: 1));
    try {
      var sleep = await FirebaseFirestore.instance
          .collection('sleep')
          .where('time', isGreaterThanOrEqualTo: start)
          .where('time', isLessThan: end)
          .get();
      return sleep.docs.map((e) => e.data()).toList();
    } catch (e) {
      print(e);
      return RequestStatus.request500InternalServerError;
    }
  }

}