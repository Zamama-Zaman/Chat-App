import 'package:chat_app/Feature/data/data_source/firebase_remote_datasource.dart';
import 'package:chat_app/Feature/data/data_source/firebase_remote_datasource_impl.dart';
import 'package:chat_app/Feature/data/repositories/firebasee_repository_impl.dart';
import 'package:chat_app/Feature/domain/usecases/get_create_current_user.dart';
import 'package:chat_app/Feature/domain/usecases/get_current_user_id_usecase.dart';
import 'package:chat_app/Feature/domain/usecases/get_messages_usecase.dart';
import 'package:chat_app/Feature/domain/usecases/get_useres_usecase.dart';
import 'package:chat_app/Feature/domain/usecases/is_signin_usecase.dart';
import 'package:chat_app/Feature/domain/usecases/send_text_message_usecase.dart';
import 'package:chat_app/Feature/domain/usecases/sign_out_usecase.dart';
import 'package:chat_app/Feature/domain/usecases/signin_usecase.dart';
import 'package:chat_app/Feature/domain/usecases/signup_usecase.dart';
import 'package:chat_app/Feature/presentation/controllers/auth/auth_controller.dart';
import 'package:chat_app/Feature/presentation/controllers/communication/communication_controller.dart';
import 'package:chat_app/Feature/presentation/controllers/login/login_controller.dart';
import 'package:chat_app/Feature/presentation/controllers/user/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    // * External
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    // * Data Source
    Get.lazyPut(
        () => FirebaseRemoteDataSourceImpl(auth: auth, firestore: firestore));
    Get.lazyPut<FirebaseRemoteDataSource>(
        () => Get.find<FirebaseRemoteDataSourceImpl>());

    // * Repository
    Get.put(FireBaseRepositoryImpl(
        firebaseRemoteDataSource: Get.find<FirebaseRemoteDataSourceImpl>()));

    // * Usecase
    Get.put(GetCurrentUserUidUseCase(
        repository: Get.find<FireBaseRepositoryImpl>()));
    Get.put(IsSignInUseCase(repository: Get.find<FireBaseRepositoryImpl>()));
    Get.put(SignOutUseCase(repository: Get.find<FireBaseRepositoryImpl>()));
    Get.put(SignUpUseCase(repository: Get.find<FireBaseRepositoryImpl>()));
    Get.put(SignInUseCase(repository: Get.find<FireBaseRepositoryImpl>()));
    Get.put(GetCreateCurrentUser(
        fireBaseRepository: Get.find<FireBaseRepositoryImpl>()));
    Get.put(SignOutUseCase(repository: Get.find<FireBaseRepositoryImpl>()));
    Get.put(GetUsersUseCase(repository: Get.find<FireBaseRepositoryImpl>()));
    Get.put(GetMessagesUseCase(repository: Get.find<FireBaseRepositoryImpl>()));
    Get.put(
        SendTextMessageUseCase(repository: Get.find<FireBaseRepositoryImpl>()));

    // Controllers
    Get.put(AuthController(
        getCurrentUserUidUseCase: Get.find<GetCurrentUserUidUseCase>(),
        isSignInUseCase: Get.find<IsSignInUseCase>(),
        signOutUseCase: Get.find<SignOutUseCase>()));
    Get.put(LoginController(
        signUpUseCase: Get.find<SignUpUseCase>(),
        signInUseCase: Get.find<SignInUseCase>(),
        getCreateCurrentUser: Get.find<GetCreateCurrentUser>(),
        signOutUseCase: Get.find<SignOutUseCase>()));
    Get.put(UserController(usersUseCase: Get.find<GetUsersUseCase>()));
    Get.put(CommunicationController(
        getMessagesUseCase: Get.find<GetMessagesUseCase>(),
        sendTextMessageUseCase: Get.find<SendTextMessageUseCase>()));
  }
}
