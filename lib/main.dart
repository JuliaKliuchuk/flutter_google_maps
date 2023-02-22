import 'package:flutter/material.dart';
import 'package:flutter_google_maps/routes/route.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: AuthorizationPage(),
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
      ),
      initialRoute: RouteHelper.getAuthorizationPage(),
      getPages: RouteHelper.routes,
    );
  }
}
