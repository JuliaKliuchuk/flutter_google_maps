import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/repository/map_repo.dart';
import '../models/image_model.dart';
import 'auth_controller.dart';
import 'images_controller.dart';

class MapController extends GetxController {
  final MapRepo mapRepo;

  MapController({required this.mapRepo});

  late Position _userPosition;
  Position get userPosition => _userPosition;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  late List<ImageModel> _imageList;
  List<ImageModel> get imageList => _imageList;

  final Set<Marker> markers = {};

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Position getUserPosition() {
    _userPosition = Get.find<AuthController>().userPosition;
    getImagesLatLng();
    return _userPosition;
  }

  getImagesLatLng() {
    _imageList = Get.find<ImageController>().imageList;
  }

  Set<Marker> getMarkers() {
    for (var image in imageList) {
      {
        markers.add(
          Marker(
              markerId: MarkerId(image.id.toString()),
              position: LatLng(image.lat!, image.lng!),
              icon: BitmapDescriptor.defaultMarker),
        );
      }
    }

    return markers;
  }
}
