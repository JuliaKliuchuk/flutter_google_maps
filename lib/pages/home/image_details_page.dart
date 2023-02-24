import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/comment_controller.dart';
import '../../controllers/images_controller.dart';
import '../../widgets/custom_snack_bar.dart';
import 'chat/comment_widget.dart';

class ImageDetailsPage extends StatefulWidget {
  final int pageId;

  const ImageDetailsPage({super.key, required this.pageId});

  @override
  State<ImageDetailsPage> createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  final _inputController = TextEditingController();

  void postComment(CommentController commentController) {
    String comment = _inputController.text.trim();

    if (comment != '') {
      commentController
          .postComment(comment, commentController.imageId)
          .then((resp) {
        if (resp.statusCode == 200) {
          Get.find<CommentController>()
              .getCommentList(commentController.imageId);
        } else {
          customSnackBar('Message not sent');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var image = Get.find<ImageController>().imageList[widget.pageId];

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            GetBuilder<ImageController>(builder: (imageController) {
              return Column(
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
              );
            }),
            GetBuilder<CommentController>(builder: (commentController) {
              return Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: commentController.commentList.length,
                      itemBuilder: ((context, index) {
                        String text =
                            commentController.commentList[index].text!;
                        String date = commentController.convertDate(
                            commentController.commentList[index].date!);
                        return CommentWidget(
                          text: text,
                          date: date,
                        );
                      }),
                    ),
                  ),
                  // input
                  Container(
                    height: 80,
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(width: 1.0, color: Colors.black12),
                    )),
                    child: TextField(
                      controller: _inputController,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        hintText: 'Enter a message',
                        suffixIcon: IconButton(
                          color: Colors.green,
                          onPressed: (() {
                            postComment(commentController);
                            _inputController.clear();
                          }),
                          icon: const Icon(Icons.send_rounded),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
