import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../data/repository/image_repo.dart';
import '../models/image_model.dart';

class ImageController extends GetxController {
  final ImageRepo imageRepo;

  ImageController({required this.imageRepo});

  late List<ImageModel> _imageList = [];
  List<ImageModel> get imageList => _imageList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  final ImagePicker _picker = ImagePicker();
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  late Position _position;
  Position get position => _position;

  late PickedFile _pickedFile;
  PickedFile get pickedFile => _pickedFile;

  Future<void> getImageList() async {
    Response response = await imageRepo.getImageList();

    if (response.statusCode == 200) {
      _imageList = [];
      _imageList.addAll(Images.fromJson(response.body).images);

      _isLoaded = true;
      update();
    }
  }

  Future<PickedFile> getImage() async {
    try {
      _pickedFile = (await _picker.getImage(
        source: ImageSource.camera,
        maxHeight: 1280,
        maxWidth: 1280,
      ))!;

      // if (_pickedFile == null) return pickedFile;
    } on PlatformException {
      if (kDebugMode) {
        print('error');
      }
    }
    return pickedFile;
  }

  Future<String> pickImageBase64(PickedFile pickedFile) async {
    late String base64Img;

    // read picked image byte data.
    Uint8List imagebytes = await File(pickedFile.path).readAsBytes();
    // using base64 encoder convert image into base64 string.
    base64Img = base64.encode(imagebytes);

    return base64Img;
  }

  Future<Position> getCurrentPosition() async {
    Position currentPosition = await _geolocatorPlatform.getCurrentPosition();

    _position = Position(
      longitude: currentPosition.longitude,
      latitude: currentPosition.latitude,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
    );

    return _position;
  }

  int formatDate(DateTime dateTime) {
    final DateFormat format = DateFormat('yyyy-MM-dd');
    final String formatted = format.format(dateTime);
    var date = int.parse(formatted.toString().replaceAll('-', ''));

    return date;
  }

  Future<Response> postImage(ImageModel imageModel) async {
    return await imageRepo.postImage(imageModel);
  }
}
