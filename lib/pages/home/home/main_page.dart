import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as drift;

import 'package:flutter_google_maps/controllers/comment_controller.dart';
import 'package:flutter_google_maps/controllers/images_controller.dart';
import 'package:flutter_google_maps/database/database.dart';
import 'package:flutter_google_maps/routes/route.dart';
import 'package:flutter_google_maps/widgets/navBar.dart';
import 'package:flutter_google_maps/widgets/custom_snack_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Database _db;
  @override
  void initState() {
    super.initState();
    _db = Get.find<ImageController>().db;
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
                  stream: _db.imageDao.watchImagesList,
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
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getImageDetailPage(
                                  imageData[index].id!));
                              Get.find<CommentController>()
                                  .getCommentList(imageData[index].id!);
                            },
                            onLongPress: () {
                              _showAlertDialog(imageData[index].id!);
                            },
                            child: Container(
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
                                        imageData[index].url!,
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
                                    child: Text(imageController
                                        .convertDate(imageData[index].date)),
                                  ),
                                ],
                              ),
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

  void postImage(ImageController imageController) async {
    var imageFile = await imageController.getImage();

    if (imageFile.path != '') {
      var imageData = Get.find<ImageController>().imageData;

      _db.imageDao
          .insertImage(ImageCompanion(
        base64Image: drift.Value(imageData.base64Image ?? ''),
        date: drift.Value(imageData.date!),
        lat: drift.Value(imageData.lat!),
        lng: drift.Value(imageData.lng!),
      ))
          .then((value) {
        imageController.postImage(imageData).then((resp) {
          if (resp.statusCode == 200) {
            Get.find<ImageController>().getImageList();
          } else {
            customSnackBar('Failed to send photo');
          }
        });
      });
    } else {
      return;
    }
  }

  Future<void> _loadResource() async {
    await Get.find<ImageController>().getImageList();
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
