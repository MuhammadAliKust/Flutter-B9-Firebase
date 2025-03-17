import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b9/models/user.dart';

class UserServices {
  ///Create User
  Future createUser(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection('user1Collection')
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }

  ///Get User by ID
  Future<UserModel> getUserByID(String userID) async {
    return await FirebaseFirestore.instance
        .collection('user1Collection')
        .doc(userID)
        .get()
        .then((val) {
      return UserModel.fromJson(val.data()!);
    });
  }

  ///Update User Profile
  Future updateTask(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection('user1Collection')
        .doc(model.docId)
        .update({
      "name": model.name,
      "phone": model.phone,
    });
  }
}
