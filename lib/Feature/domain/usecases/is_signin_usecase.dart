import 'package:chat_app/Feature/domain/repositories/firebase_repository.dart';

class IsSignInUseCase {
  final FireBaseRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() async => repository.isSignIn();
}
