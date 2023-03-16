import 'package:blocdating/models/user_model.dart';
import 'package:blocdating/repositories/database/base_database_repository.dart';
import 'package:blocdating/repositories/storage/storage_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser() {
    return _firebaseFirestore
        .collection('users')
        .doc('zWUccIB7huaxa753WOxo')
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<void> updateUserPictures(String imageName) async {
    String downloadUrl = await StorageRepository().getDownloadUrl(imageName);
    return _firebaseFirestore
        .collection("users")
        .doc("zWUccIB7huaxa753WOxo")
        .update(
      {
        "imageUrls": FieldValue.arrayUnion([downloadUrl])
      },
    );
  }
}
