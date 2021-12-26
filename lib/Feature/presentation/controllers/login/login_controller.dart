import 'dart:io';

import 'package:chat_app/Feature/domain/usecases/get_create_current_user.dart';
import 'package:chat_app/Feature/domain/usecases/sign_out_usecase.dart';
import 'package:chat_app/Feature/domain/usecases/signin_usecase.dart';
import 'package:chat_app/Feature/domain/usecases/signup_usecase.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final GetCreateCurrentUser getCreateCurrentUser;
  final SignOutUseCase signOutUseCase;

  LoginController({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.getCreateCurrentUser,
    required this.signOutUseCase,
  });

  RxBool isLoading = false.obs;

  Future<bool> submitLogin(
      {required String email, required String password}) async {
    try {
      showLoading();
      await signInUseCase.call(email, password);
      hideLoading();
      return true;
    } on SocketException catch (e) {
      print(e);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> submitRegistration(
      {required String email,
      required String password,
      required String name}) async {
    try {
      showLoading();
      await signUpUseCase.call(email, password);
      await getCreateCurrentUser.call(email, name, "");
      hideLoading();
      return true;
    } on SocketException catch (e) {
      print(e);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> submitSignOut() async {
    try {
      await signOutUseCase.call();
    } on SocketException catch (_) {}
  }

  showLoading() {
    isLoading.toggle();
  }

  hideLoading() {
    isLoading.toggle();
  }
}
