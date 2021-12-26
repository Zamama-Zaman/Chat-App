import 'package:chat_app/Feature/data/data_source/firebase_remote_datasource.dart';
import 'package:chat_app/Feature/domain/entities/text_message_entity.dart';
import 'package:chat_app/Feature/domain/entities/user_entity.dart';
import 'package:chat_app/Feature/domain/repositories/firebase_repository.dart';

class FireBaseRepositoryImpl implements FireBaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;

  FireBaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<bool> isSignIn() => firebaseRemoteDataSource.isSignIn();

  @override
  Future<String> getCurrentUserId() =>
      firebaseRemoteDataSource.getCurrentUserId();

  @override
  Future<void> signIn(String email, String password) async =>
      await firebaseRemoteDataSource.signIn(
        email,
        password,
      );

  @override
  Future<void> signUp(String email, String password) async =>
      await firebaseRemoteDataSource.signUp(
        email,
        password,
      );

  @override
  Future<void> getCreateCurrentUser(
    String email,
    String name,
    String profileUrl,
  ) async {
    return await firebaseRemoteDataSource.getCreateCurrentUser(
      email,
      name,
      profileUrl,
    );
  }

  @override
  Stream<List<TextMessageEntity>> getMessages() {
    return firebaseRemoteDataSource.getMessages();
  }

  @override
  Future<UserEntity> getUsers(String uid) {
    return firebaseRemoteDataSource.getUsers(uid);
  }

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessage) {
    return firebaseRemoteDataSource.sendTextMessage(textMessage);
  }

  @override
  Future<void> signOut() => firebaseRemoteDataSource.signOut();
}
