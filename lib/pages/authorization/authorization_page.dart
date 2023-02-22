import 'package:flutter/material.dart';
import 'package:flutter_google_maps/utils/colors.dart';

import 'login_screen.dart';
import 'register_screen.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Login'),
    Tab(text: 'Register'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          bottom: const TabBar(tabs: myTabs, indicatorColor: Colors.white),
        ),
        body: const TabBarView(
          children: [
            Login(),
            Register(),
          ],
        ),
      ),
    );
  }
}
