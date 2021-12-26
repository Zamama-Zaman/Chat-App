import 'package:chat_app/Feature/domain/repositories/firebase_repository.dart';

class GetCurrentUserUidUseCase {
  final FireBaseRepository repository;

  GetCurrentUserUidUseCase({required this.repository});

  Future<String> call() async {
    return repository.getCurrentUserId();
  }
}
