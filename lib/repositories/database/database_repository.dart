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
  Stream<List<User>> getUsers(User user) {
    List<String> userFilter = List.from(user.swipeLeft!)
      ..addAll(user.swipeRight!)
      ..add(user.id!);

    return _firebaseFirestore
        .collection('users')
        .where('gender', isEqualTo: 'Female')
        .where(FieldPath.documentId, whereNotIn: userFilter)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<List<User>> getUsersV2(User user) {
    List<String> userFilter = List.from(user.swipeLeft!)
      ..addAll(user.swipeRight!)
      ..add(user.id!);

    return _firebaseFirestore
        .collection('users')
        .where('gender', isEqualTo: 'Female')
        .where(FieldPath.documentId, whereNotIn: userFilter)
        .get()
        .then((snap) {
      return snap.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<void> updateUserSwipe(
      String userId, String matchId, bool isSwipeRight) async {
    if (isSwipeRight) {
      await _firebaseFirestore.collection('users').doc(userId).update({
        'swipeRight': FieldValue.arrayUnion([matchId])
      });
    } else {
      await _firebaseFirestore.collection('users').doc(userId).update({
        'swipeLeft': FieldValue.arrayUnion([matchId])
      });
    }
  }

  @override
  Future<void> updateUserMatch(String userId, String matchId) async {
    // Add the match into the current user document.
    await _firebaseFirestore.collection('users').doc(userId).update({
      'matches': FieldValue.arrayUnion([matchId])
    });
    // Add the match into the other user document.
    await _firebaseFirestore.collection('users').doc(matchId).update({
      'matches': FieldValue.arrayUnion([userId])
    });
  }
}
