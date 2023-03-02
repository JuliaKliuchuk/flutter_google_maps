import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/database/database.dart';
import 'package:flutter_google_maps/widgets/navBar.dart';
import 'package:get/get.dart';

import '../../../controllers/images_controller.dart';
import '../../../widgets/custom_snack_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _db = Get.find<ImageController>().db;

  Future<void> _loadResource() async {
    await Get.find<ImageController>().getImageList();
  }

  @override
  void initState() {
    super.initState();

    _db.getImages().then((value) => log('image -------$value'));
    // _db.watchImagesList.listen((dataImage) {
    //   log('Image-item in database: $dataImage');
    // });
  }

  void postImage(ImageController imageController) async {
    var imageFile = await imageController.getImage();

    if (imageFile.path != '') {
      var imageData = Get.find<ImageController>().imageData;

      imageController.postImage(imageData).then((resp) {
        if (resp.statusCode == 200) {
          Get.find<ImageController>().getImageList();
        } else {
          customSnackBar('Failed to send photo');
        }
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageController>(builder: (imageController) {
      return Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          onRefresh: () => _loadResource(),
          child: imageController.isLoaded
              ? StreamBuilder<List<ImageData>>(
                  stream: _db.watchImagesList,
                  builder: ((context, snapshot) {
                    final List<ImageData>? imageData = snapshot.data;

                    if (snapshot.connectionState != ConnectionState.active) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    if (imageData != null) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(20.0),
                        itemCount: imageData.length,
                        itemBuilder: (context, index) {
                          final image = imageData[index];
                          return Container(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // img
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: SizedBox(
                                    height: 300.0,
                                    child: Image.network(
                                      image.url, // this image doesn't exist
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'assets/not_found.png',
                                            fit: BoxFit.cover);
                                      },
                                    ),
                                  ),
                                ),
                                // title
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 5.0),
                                  child: Text(
                                      imageController.convertDate(image.date)),
                                ),
                              ],
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.85,
                        ),
                      );
                    }

                    return const Text('No data');
                  }),
                )
              : const Center(
                  child: CircularProgressIndicator(),
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

  Future<void> _showAlertDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GetBuilder<ImageController>(builder: (imageController) {
          return AlertDialog(
            title: const Text('Delete image'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Are you sure you want to delete the photo?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();
                  imageController.deleteImage(id);
                  Get.find<ImageController>().getImageList();
                },
              ),
            ],
          );
        });
      },
    );
  }
}
