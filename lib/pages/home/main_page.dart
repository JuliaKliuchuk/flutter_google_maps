import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/pages/home/navBar.dart';
import 'package:get/get.dart';

import '../../controllers/images_controller.dart';
import '../../routes/route.dart';
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

  void postImage(ImageController imageController) async {
    await imageController.getImage();
    imageController.postImage(imageController.imageData).then((resp) {
      if (resp.statusCode == 200) {
        Get.find<ImageController>().getImageList();
      } else {
        customSnackBar('Failed to send photo');
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
          child: imageController.isLoaded
              ? GridView.builder(
                  padding: const EdgeInsets.all(20.0),
                  itemCount: imageController.imageList.length,
                  itemBuilder: (context, index) => Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getImageDetailPage(
                            imageController.imageList[index].id!));
                      },
                      onLongPress: () {
                        _showAlertDialog(imageController.imageList[index].id!);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // img
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 300.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      imageController.imageList[index].url!),
                                ),
                              ),
                            ),
                          ),
                          // title
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 5.0),
                            child: Text(
                              imageController.imageList[index].date.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
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
