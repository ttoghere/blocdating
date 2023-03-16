import 'dart:io';

import 'package:blocdating/repositories/database/database_repository.dart';
import 'package:blocdating/repositories/storage/base_storage_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

class StorageRepository extends BaseStorageRepository {
  final fStorage.FirebaseStorage storage = fStorage.FirebaseStorage.instance;
  @override
  Future<void> uploadImage(XFile image) async {
    try {
      await storage.ref("user_1/${image.name}").putFile(File(image.path)).then(
            (p0) => DatabaseRepository().updateUserPictures(image.name),
          );
    } catch (_) {}
  }

  @override
  Future<String> getDownloadUrl(String imageName) async {
    String downloadUrl =
        await storage.ref("user_1/$imageName").getDownloadURL();
    return downloadUrl;
  }
}
