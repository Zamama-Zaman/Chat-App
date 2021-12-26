import 'package:chat_app/Feature/presentation/controllers/auth/auth_controller.dart';
import 'package:chat_app/Feature/presentation/controllers/user/user_controller.dart';
import 'package:chat_app/Feature/presentation/pages/login_registration_page.dart';
import 'package:chat_app/Feature/presentation/pages/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class WelcomePage extends StatefulWidget {
  final String uid;

  const WelcomePage({Key? key, required this.uid}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();

  @override
  void initState() {
    userController.getUsers(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return userController.isLoading.isTrue
            ? _loadingWidget()
            : Scaffold(
                body: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF15B4AF),
                            Colors.yellow.shade400,
                            // Colors.blue.shade300,
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 80),
                        child: Text(
                          "Welcome ${userController.userEntity?.value.name}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    _joinGlobalChatButton(
                        userController.userEntity?.value.name, context),
                    _logOutWidget(),
                  ],
                ),
              );
      },
    );
  }

  Widget _loadingWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                const Color(0xFF15B4AF),
                Colors.blue.shade300,
              ],
            )),
          ),
          const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _joinGlobalChatButton(String? name, context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Join Us For Fun",
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Get.to(
                () => ChatPage(
                  userName: name!,
                  uid: context.widget.uid,
                ),
              );
            },
            child: Container(
              width: 180,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: const Color(0xFF15B4AF),
                color: Colors.white.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(color: Colors.white60, width: 2),
              ),
              child: const Text(
                "Join",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logOutWidget() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: InkWell(
        onTap: () {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            authController.loggedOut();
            Get.offAll(const LoginAndRegistrationPage());
          });
        },
        child: Container(
          margin: const EdgeInsets.only(left: 15, bottom: 15),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.3),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.exit_to_app,
            color: Colors.red,
            size: 30,
          ),
        ),
      ),
    );
  }
}
