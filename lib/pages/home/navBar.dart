import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.green),
            child: Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text(
                'Username',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 30,
              color: Colors.black,
            ),
            title: const Text('Photos'),
            onTap: () {
              Get.toNamed(RouteHelper.getInitial());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.public,
              size: 30,
              color: Colors.black,
            ),
            title: const Text('Map'),
            onTap: () {
              Get.toNamed(RouteHelper.getMapPage());
            },
          ),
        ],
      ),
    );
  }
}
