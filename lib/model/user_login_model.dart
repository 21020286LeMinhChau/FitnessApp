import 'package:fitness/common/request_status.dart';
import 'package:fitness/service/user_service.dart';

class UserLoginModel {
  String password;
  String gmail;

  UserLoginModel({
    required this.password,
    required this.gmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'gmail': gmail,
    };
  }

  isValidForm() {
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

  // login() {
  //   return UserService().login(this);
  // }
}
