import 'dart:io';

import 'package:blocdating/models/user_model.dart';
import 'package:blocdating/repositories/database/database_repository.dart';
import 'package:blocdating/repositories/storage/base_storage_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageRepository extends BaseStorageRepository {
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  @override
  Future<void> uploadImage(User user, XFile image) async {
    try {
      await storage
          .ref("${user.id}/${image.name}")
          .putFile(File(image.path))
          .then(
            (p0) => DatabaseRepository().updateUserPictures(user, image.name),
          );
    } catch (_) {}
  }

  @override
  Future<String> getDownloadUrl(User user,String imageName) async {
    String downloadUrl =
        await storage.ref("${user.id}/$imageName").getDownloadURL();
    return downloadUrl;
  }
}
