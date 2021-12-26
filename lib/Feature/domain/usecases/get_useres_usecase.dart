import 'package:chat_app/Feature/domain/entities/user_entity.dart';
import 'package:chat_app/Feature/domain/repositories/firebase_repository.dart';

class GetUsersUseCase {
  final FireBaseRepository repository;

  GetUsersUseCase({required this.repository});

  Future<UserEntity> call(String uid) => repository.getUsers(uid);
}
