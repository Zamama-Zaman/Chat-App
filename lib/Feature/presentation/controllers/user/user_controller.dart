import 'dart:io';
import 'package:chat_app/Feature/domain/entities/user_entity.dart';
import 'package:chat_app/Feature/domain/usecases/get_useres_usecase.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final GetUsersUseCase usersUseCase;

  UserController({required this.usersUseCase});

  Rx<UserEntity>? userEntity;

  RxBool isLoading = false.obs;

  Future<void> getUsers({required String uid}) async {
    try {
      isLoading.toggle();
      final result = await usersUseCase.call(uid);
      userEntity = result.obs;
      isLoading.toggle();
    } on SocketException catch (_) {}
  }
}
