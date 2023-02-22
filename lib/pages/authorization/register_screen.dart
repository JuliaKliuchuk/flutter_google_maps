import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/images_controller.dart';
import '../../models/auth_model.dart';
import '../../routes/route.dart';
import '../../widgets/custom_snack_bar.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  void registration(AuthController authController) {
    String login = _loginController.text.trim();
    String password = _passController.text.trim();

    if (_formKey.currentState!.validate()) {
      AuthModel data = AuthModel(
        login: login,
        password: password,
      );
      authController.registration(data).then((resp) {
        if (resp.status == 200) {
          Get.offNamed(RouteHelper.getInitial());
          Get.find<ImageController>().getImageList();
        } else {
          customSnackBar('User with such data already exists');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

              // confirm password
              const SizedBox(height: 20),
              TextFormField(
                // obscureText: true,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '******',
                ),
                validator: _validateConfirmPass,
                controller: _confirmPassController,
              ),

              // submit button
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => registration,
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

  String? _validateConfirmPass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (value.length != 8) {
      return 'Password can not be less than 8 characters';
    } else if (_passController.text != value) {
      return 'Password mismatch';
    } else {
      return null;
    }
  }
}
