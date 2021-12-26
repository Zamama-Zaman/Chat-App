import 'package:chat_app/Feature/presentation/controllers/auth/auth_controller.dart';
import 'package:chat_app/Feature/presentation/controllers/login/login_controller.dart';
import 'package:chat_app/Feature/presentation/pages/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAndRegistrationPage extends StatefulWidget {
  const LoginAndRegistrationPage({Key? key}) : super(key: key);

  @override
  _LoginAndRegistrationPageState createState() =>
      _LoginAndRegistrationPageState();
}

class _LoginAndRegistrationPageState extends State<LoginAndRegistrationPage> {
  final controller = Get.find<AuthController>();

  final loginController = Get.find<LoginController>();
  final authController = Get.find<AuthController>();

  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  dispose() {
    _nameController!.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  bool isLoginPage = true;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    checkUserLogin();
    super.initState();
  }

  void checkUserLogin() async {
    bool check = await controller.appStart();
    if (check) {
      // authController.loggedOut();
      Get.offAll(WelcomePage(uid: controller.currendUserId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    _imageWidget(),
                    const Text(
                      'Chat App',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _fromWidget(),
                    const SizedBox(
                      height: 15,
                    ),
                    _buttonWidget(),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _rowTextWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageWidget() {
    return SizedBox(
      height: 250,
      width: 250,
      child: Image.asset("assets/images/group_logo-removebg-preview.png"),
    );
  }

  Widget _fromWidget() {
    return Column(
      children: [
        isLoginPage == true
            ? const Text(
                "",
                style: TextStyle(fontSize: 0),
              )
            : Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "User Name",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
              ),
        isLoginPage == true
            ? const Text(
                "",
                style: TextStyle(fontSize: 0),
              )
            : const SizedBox(
                height: 20,
              ),
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Email Address",
              prefixIcon: Icon(Icons.alternate_email),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Password",
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonWidget() {
    return InkWell(
      onTap: () {
        if (isLoginPage == true) {
          _submitLogin();
        } else {
          _submitRegistration();
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Text(
          isLoginPage == true ? "LOGIN" : "REGISTER",
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _rowTextWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLoginPage == true ? "Don't have account?" : "Have an account?",
          style: TextStyle(fontSize: 16, color: Colors.indigo[400]),
        ),
        InkWell(
          onTap: () {
            setState(() {
              if (isLoginPage == true) {
                isLoginPage = false;
              } else {
                isLoginPage = true;
              }
            });
          },
          child: Text(
            isLoginPage == true ? " Sign Up" : " Sign In",
            style: const TextStyle(
                fontSize: 16,
                color: Colors.indigo,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _submitLogin() async {
    if (_emailController!.text.isNotEmpty &&
        _passwordController!.text.isNotEmpty) {
      final result = await loginController.submitLogin(
          email: _emailController!.text.toString(),
          password: _passwordController!.text.toString());
      if (result) {
        final uid = await authController.loggedIn();
        Get.offAll(WelcomePage(uid: uid));
      } else {
        Get.snackbar('Error', 'Login Incorrect');
      }
    }
  }

  void _submitRegistration() async {
    if (_emailController!.text.isNotEmpty &&
        _passwordController!.text.isNotEmpty &&
        _nameController!.text.isNotEmpty) {
      final result = await loginController.submitRegistration(
          email: _emailController!.text.toString(),
          password: _passwordController!.text.toString(),
          name: _nameController!.text.toString());
      if (result) {
        final uid = await authController.loggedIn();
        Future.delayed(const Duration(seconds: 5), () {
          Get.offAll(WelcomePage(uid: uid));
        });
      }
    }
  }
}
