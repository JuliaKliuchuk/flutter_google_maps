import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/images_controller.dart';

class ImageDetailsPage extends StatelessWidget {
  final int pageId;

  const ImageDetailsPage({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var image = Get.find<ImageController>().imageList[pageId];

    //  int id = imageController.imageList[index].id!;
    //                   Get.find<CommentController>().setImgId(id);
    //                   Get.find<CommentController>().getCommentList(id);

    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: GetBuilder<ImageController>(builder: (imageController) {
            return Column(
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(image.url!),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.grey[350],
                        child: Text(imageController.convertDate(image.date)),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.34,
                //   child: const Chat(),
                // ),
              ],
            );
          }),
        ));
  }
}
