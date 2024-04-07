import 'dart:ffi';

import 'package:fitness/common/request_status.dart';
import 'package:fitness/service/user_service.dart';

class UserCompleteProfile {
  String gmail = "k@";
  String gender;
  String weight;
  String height;
  // type date with dateOfBirth
  String dateOfBirth;

  UserCompleteProfile({
    required this.gender,
    required this.weight,
    required this.height,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toMap() {
    return {
      'gmail': gmail,
      'gender': gender,
      'weight': weight,
      'height': height,
      'dateOfBirth': dateOfBirth,
    };
  }

  isValidForm() {
    if (gender != 'Male' && gender != 'Female') {
      return "Please select";
    }
    if (dateOfBirth.isEmpty) {
      return "Please enter date of birth";
    }
    if (weight.isEmpty) {
      return "Please enter weight";
    }
    if (height.isEmpty) {
      return "Please enter height";
    }

    try {
      // dateOfBirth = "dd/mm/yyyy"
      var dateOfBirthSplit = dateOfBirth.split("/");
      if (dateOfBirthSplit.length != 3) {
        return "Invalid date of birth, please enter a valid date (dd/mm/yyyy)";
      }
      var day = int.parse(dateOfBirthSplit[0]);
      var month = int.parse(dateOfBirthSplit[1]);
      var year = int.parse(dateOfBirthSplit[2]);
      if (day < 1 || day > 31) {
        return "Invalid date of birth, please enter a valid date (dd/mm/yyyy)";
      }
      if (month < 1 || month > 12) {
        return "Invalid date of birth, please enter a valid date (dd/mm/yyyy)";
      }
      if (year < 1900 || year > 2021) {
        return "Invalid date of birth, please enter a valid date (dd/mm/yyyy)";
      }
    } catch (e) {
      return "Invalid date of birth, please enter a valid date (dd/mm/yyyy)";
    }

    try {
      double.parse(weight);
    } catch (e) {
      return "Invalid weight, please enter a number";
    }

    try {
      double.parse(height);
    } catch (e) {
      return "Invalid height, please enter a number";
    }

    return RequestStatus.request200Ok;
  }

  updateProfile() {
    return UserService().completeProfile(this);
  }
}
