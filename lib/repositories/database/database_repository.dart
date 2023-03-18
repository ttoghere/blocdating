import 'dart:developer';

import 'package:blocdating/models/user_model.dart';
import 'package:blocdating/repositories/database/base_database_repository.dart';
import 'package:blocdating/repositories/storage/storage_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<void> updateUserPictures(User user, String imageName) async {
    String downloadUrl =
        await StorageRepository().getDownloadUrl(user, imageName);
    return _firebaseFirestore.collection("users").doc(user.id).update(
      {
        "imageUrls": FieldValue.arrayUnion([downloadUrl])
      },
    );
  }

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore.collection("users").doc(user.id).set(user.toMap());
  }

  @override
  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection("users")
        .doc(user.id)
        .update(user.toMap())
        .then((value) {
      log("User Document Updated...");
    });
  }

  @override
  Stream<List<User>> getUsers(String userId, String gender) {
    return _firebaseFirestore
        .collection("users")
        .where("gender", isNotEqualTo: gender)
        .snapshots()
        .map((snap) {
      return snap.docs.map((e) => User.fromSnapshot(e)).toList();
    });
  }
}
