import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/common/request_status.dart';
import 'package:fitness/model/user_complete_profile.dart';
import 'package:fitness/model/user_login_model.dart';
import 'package:fitness/model/user_register_model.dart';
import 'package:fitness/view/login/complete_profile_view.dart';

class UserService {
  static const collectionUser = "user";

  Future createUser(UserRegisterModel userInformationCreate) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collectionUser)
        .where('gmail', isEqualTo: userInformationCreate.gmail)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return RequestStatus.request409Conflict;
    }

    try {
      await FirebaseFirestore.instance
          .collection(collectionUser)
          .add(userInformationCreate.toMap());
      return RequestStatus.request201Created;
    } catch (e) {
      return RequestStatus.request500InternalServerError;
    }
  }

  Future login(UserLoginModel userLoginInformation) {
    return FirebaseFirestore.instance
        .collection(collectionUser)
        .where('gmail', isEqualTo: userLoginInformation.gmail)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        return RequestStatus.request404NotFound;
      }

      if (value.docs.first.get('password') == userLoginInformation.password) {
        return RequestStatus.request200Ok;
      }

      return RequestStatus.request401Unauthorized;
    });
  }

  Future completeProfile(UserCompleteProfile userCompleteProfile) {
    return FirebaseFirestore.instance
        .collection(collectionUser)
        .where('gmail', isEqualTo: userCompleteProfile.gmail)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        return RequestStatus.request404NotFound;
      }

      try {
        FirebaseFirestore.instance
            .collection(collectionUser)
            .doc(value.docs.first.id)
            .update(userCompleteProfile.toMap());
        return RequestStatus.request200Ok;
      } catch (e) {
        return RequestStatus.request500InternalServerError;
      }
    });
  }
}
