import 'package:chat_app/Feature/domain/repositories/firebase_repository.dart';

class SignInUseCase {
  final FireBaseRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
