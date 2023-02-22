import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../routes/route.dart';
import '../../widgets/custom_snack_bar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _passController = TextEditingController();

  void login(AuthController authController) {
    String login = _loginController.text.trim();
    String password = _passController.text.trim();

    if (_formKey.currentState!.validate()) {
      authController.login(login, password).then((resp) {
        if (resp.status == 200) {
          Get.toNamed(RouteHelper.getInitial());
        } else {
          customSnackBar('User not registered');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //login
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Login',
                  ),
                  validator: _validateLogin,
                  controller: _loginController,
                ),

                // password
                const SizedBox(height: 20),
                TextFormField(
                  // obscureText: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: '******',
                  ),
                  validator: _validatePass,
                  controller: _passController,
                ),

                // submit button
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => login(authController),
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(color: Colors.green),
                    child: const Center(
                      child: Text(
                        'LOG IN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  String? _validateLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter login';
    } else {
      return null;
    }
  }

  String? _validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (value.length != 8) {
      return 'Password can not be less than 8 characters';
    } else {
      return null;
    }
  }
}
