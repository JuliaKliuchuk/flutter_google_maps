import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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

  late XFile _pickedImg;

  late String _base64Img;
  String get base64Img => _base64Img;

  late ImageModel _imageData;
  ImageModel get imageData => _imageData;

  Future<void> getImageList() async {
    update();

    Response response = await imageRepo.getImageList();

    if (response.statusCode == 200) {
      _imageList = [];
      _imageList.addAll(Image.fromJson(response.body).images);

      _isLoaded = true;
      update();
    }
  }

  Future<XFile> getImage() async {
    _isLoaded = true;
    try {
      _pickedImg = (await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1280,
        maxWidth: 1280,
        imageQuality: 50,
      ))!;

      if (_pickedImg.path == '') return _pickedImg;

      await imageToBase64(_pickedImg);
    } catch (e) {
      print('Error: $e');
    }

    return _pickedImg;
  }

  Future<String> imageToBase64(XFile image) async {
    var fileCompress = await compressImg(File(image.path));
    Uint8List imagebytes =
        await File(fileCompress!.absolute.path).readAsBytes();

    _base64Img = base64.encode(imagebytes);

    if (_base64Img != '') {
      await getCurrentPosition();
    }

    return _base64Img;
  }

  Future<File?> compressImg(File file) async {
    final filePath = file.absolute.path;

    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      minWidth: 1280,
      minHeight: 1280,
      quality: 5,
    );

    return result;
  }

  Future getCurrentPosition() async {
    Position currentPosition = await _geolocatorPlatform.getCurrentPosition();

    final DateFormat format = DateFormat('yyyy-MM-dd');
    final String formatted = format.format(DateTime.now()).toString();
    int date = int.parse(formatted.replaceAll('-', ''));

    _imageData = ImageModel(
      base64Image: base64Img,
      date: date,
      lat: currentPosition.latitude,
      lng: currentPosition.longitude,
    );
    _isLoaded = false;
    update();
  }

  String convertDate(int date) {
    DateTime dataTime = DateTime.parse(date.toString());
    var result = DateFormat('dd-MM-yyyy').format(dataTime);
    return result;
  }

  Future<Response> postImage(ImageModel imageModel) async {
    return await imageRepo.postImage(imageModel);
  }

  Future<Response> deleteImage(int imageId) async {
    return await imageRepo.deleteImage(imageId);
  }
}
