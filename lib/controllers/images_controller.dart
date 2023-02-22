import 'dart:developer';

import 'package:get/get.dart';

import '../data/repository/image_repo.dart';
import '../models/image_model.dart';

class ImageController extends GetxController {
  final ImageRepo imageRepo;

  ImageController({required this.imageRepo});

  late List<ImageModel> _imageList = [];
  List<ImageModel> get imageList => _imageList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getImageList() async {
    Response response = await imageRepo.getImageList();

    log('response.body -----${response.body}');

    if (response.statusCode == 200) {
      _imageList = [];
      _imageList.addAll(Images.fromJson(response.body).images);

      _isLoaded = true;
      update();
    }
  }
}
