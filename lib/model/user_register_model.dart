import 'package:fitness/common/request_status.dart';
import 'package:fitness/service/user_service.dart';

class UserRegisterModel {
  String password;
  String gmail;
  String firstName;
  String lastName;

  UserRegisterModel(
      {required this.password,
      required this.gmail,
      required this.firstName,
      required this.lastName});

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'gmail': gmail,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  // registerUser() {
  //   return UserService().createUser(this);
  // }

  isValidForm() {
    if (firstName.isEmpty) {
      return "First name is required";
    }
    if (lastName.isEmpty) {
      return "Last name is required";
    }
    if (gmail.isEmpty) {
      return "Email is required";
    }

    if (password.isEmpty) {
      return "Password is required";
    }

    if (!gmail.contains("@")) {
      return "Invalid email";
    }

    return RequestStatus.request200Ok;
  }
}
