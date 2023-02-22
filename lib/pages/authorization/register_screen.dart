import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route.dart';
import '../../utils/colors.dart';

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Get.toNamed(RouteHelper.getInitial());
    }
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
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
                onTap: () => _submitForm(),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                  ),
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
    // String login = _loginController.text.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter login';
    } else {
      return null;
    }
  }

  String? _validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (value.length != 6) {
      return 'Password can not be less than 6 characters';
    } else {
      return null;
    }
  }

  String? _validateConfirmPass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (_passController.text != value) {
      return 'Password mismatch';
    } else {
      return null;
    }
  }
}
