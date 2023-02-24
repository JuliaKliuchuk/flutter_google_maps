import 'package:flutter/material.dart';
import 'package:flutter_google_maps/widgets/navBar.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: const Text('MapPage'),
        ),
      ),
      drawer: const NavBar(),
    );
  }
}
