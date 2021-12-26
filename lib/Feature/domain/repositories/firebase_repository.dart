import 'package:chat_app/Feature/domain/entities/text_message_entity.dart';
import 'package:chat_app/Feature/domain/entities/user_entity.dart';

abstract class FireBaseRepository {
  Future<void> signUp(String email, String password);
  Future<void> signIn(String email, String password);
  Future<String> getCurrentUserId();
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<void> getCreateCurrentUser(
      String email, String name, String profileUrl);
  Future<void> sendTextMessage(TextMessageEntity textMessage);
  Future<UserEntity> getUsers(String uid);
  Stream<List<TextMessageEntity>> getMessages();
}
