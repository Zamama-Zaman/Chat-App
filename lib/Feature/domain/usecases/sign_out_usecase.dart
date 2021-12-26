import 'package:chat_app/Feature/domain/repositories/firebase_repository.dart';

class SignOutUseCase {
  final FireBaseRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return await repository.signOut();
  }
}
