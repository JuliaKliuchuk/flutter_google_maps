import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/pages/home/navBar.dart';
import 'package:get/get.dart';

import '../../controllers/images_controller.dart';
import '../../models/image_model.dart';
import '../../widgets/custom_snack_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> _loadResource() async {
    await Get.find<ImageController>().getImageList();
  }

  void postImage(ImageController imageController) {
    imageController.getImage().then((pickedFile) async {
      late String base64Image;
      late double lat;
      late double lng;
      late int date;

      base64Image = await imageController.pickImageBase64(pickedFile);

      try {
        imageController.getCurrentPosition().then((position) {
          lat = position.latitude;
          lng = position.longitude;
          date = imageController.formatDate(position.timestamp!);

          ImageModel data = ImageModel(
            date: date,
            lat: lat,
            lng: lng,
            base64Image: base64Image,
          );

          imageController.postImage(data).then((resp) {
            if (resp.statusCode == 200) {
              Get.find<ImageController>().getImageList();
            } else {
              customSnackBar('не удалось отправить фото');
            }
          });
        });
      } catch (e) {
        print('error - $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageController>(builder: (imageController) {
      return Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          onRefresh: () => _loadResource(),
          child: GridView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: 10,
            itemBuilder: (context, i) => Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // img
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      height: 300.0,
                      color: Colors.teal[100],
                    ),
                  ),
                  // title
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 5.0),
                    child: Text(
                      'Sometext',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.85,
            ),
          ),
        ),
        drawer: const NavBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => postImage(imageController),
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
