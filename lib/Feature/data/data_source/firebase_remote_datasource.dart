import 'package:chat_app/Feature/data/models/text_message_model.dart';
import 'package:chat_app/Feature/data/models/user_model.dart';
import 'package:chat_app/Feature/domain/entities/text_message_entity.dart';
import 'package:chat_app/Feature/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> signUp(String email, String password);

  Future<void> signIn(String email, String password);

  Future<String> getCurrentUserId();

  Future<void> signOut();

  Future<bool> isSignIn();

  Future<void> getCreateCurrentUser(
      String email, String name, String profileUrl);

  Future<void> sendTextMessage(TextMessageEntity textMessage);

  Future<UserEntity> getUsers(String uid);

  Stream<List<TextMessageModel>> getMessages();
}
