import 'package:flutter/material.dart';
import 'package:flutter_google_maps/controllers/map_controller.dart';
import 'package:flutter_google_maps/widgets/navBar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../controllers/auth_controller.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Position _userPosition = Get.find<AuthController>().userPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MapPage'),
      ),
      body: GetBuilder<MapController>(builder: (mapController) {
        return Center(
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target:
                        LatLng(_userPosition.latitude, _userPosition.longitude),
                    zoom: 7),
                onMapCreated: (GoogleMapController controller) {
                  mapController.setMapController(controller);
                },
              )),
        );
      }),
      drawer: const NavBar(),
    );
  }
}
