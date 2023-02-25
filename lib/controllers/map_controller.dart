import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/repository/map_repo.dart';

class MapController extends GetxController {
  final MapRepo mapRepo;

  MapController({required this.mapRepo});

  final bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }
}
