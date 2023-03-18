import 'package:blocdating/models/user_model.dart';

abstract class BaseDatabaseRepository {
  Stream<User> getUser(String userId);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> updateUserPictures(User user, String imageName);
}
