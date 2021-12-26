import 'package:chat_app/Feature/domain/usecases/get_current_user_id_usecase.dart';
import 'package:chat_app/Feature/domain/usecases/is_signin_usecase.dart';
import 'package:chat_app/Feature/domain/usecases/sign_out_usecase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final GetCurrentUserUidUseCase getCurrentUserUidUseCase;
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;

  AuthController({
    required this.getCurrentUserUidUseCase,
    required this.isSignInUseCase,
    required this.signOutUseCase,
  });

  RxBool isLoading = false.obs;
  String? currendUserId;

  Future<bool> appStart() async {
    showLoading();
    final isSignIn = await isSignInUseCase.call();
    if (isSignIn) {
      final currentUid = await getCurrentUserUidUseCase.call();
      if (currentUid.isNotEmpty) {
        currendUserId = currentUid;
        hideLoading();
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  Future<String> loggedIn() async {
    showLoading();
    final currentUid = await getCurrentUserUidUseCase.call();
    currendUserId = currentUid;
    hideLoading();
    return currendUserId!;
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
    } catch (e) {
      print(e);
    }
  }

  showLoading() {
    isLoading.toggle();
  }

  hideLoading() {
    isLoading.toggle();
  }
}
