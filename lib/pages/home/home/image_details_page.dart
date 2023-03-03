import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_google_maps/controllers/comment_controller.dart';
import 'package:flutter_google_maps/controllers/images_controller.dart';
import 'package:flutter_google_maps/widgets/comment_widget.dart';
import 'package:flutter_google_maps/widgets/custom_snack_bar.dart';
import 'package:flutter_google_maps/database/database.dart';

class ImageDetailsPage extends StatefulWidget {
  final int pageId;

  const ImageDetailsPage({super.key, required this.pageId});

  @override
  State<ImageDetailsPage> createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  late Database _db;
  late ImageData _imageData;
  late List<CommentData> _comments = [];
  bool _isImageLoaded = false;
  bool _isCommentsLoaded = false;
  final _inputController = TextEditingController();

  @override
  initState() {
    super.initState();
    _db = Get.find<ImageController>().db;

    getImageData().then((result) {
      setState(() {
        _isImageLoaded = true;
        _imageData = result;
      });
      getComments().then((result) {
        setState(() {
          _comments = result;
          _isCommentsLoaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _isImageLoaded
                ? GetBuilder<ImageController>(builder: (imageController) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Image.network(
                            _imageData.url!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/not_found.png',
                                  fit: BoxFit.cover);
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: Colors.grey[350],
                          child: Text(
                              imageController.convertDate(_imageData.date)),
                        )
                      ],
                    );
                  })
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            _isCommentsLoaded
                ? GetBuilder<CommentController>(builder: (commentController) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.34,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: SingleChildScrollView(
                              reverse: true,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _comments.length,
                                itemBuilder: ((context, index) {
                                  String text = _comments[index].textComment;
                                  String date = commentController
                                      .convertDate(_comments[index].date);
                                  return GestureDetector(
                                    onLongPress: () {
                                      _showAlertDialog(
                                        _comments[index].id,
                                        _imageData.id!,
                                      );
                                    },
                                    child: CommentWidget(
                                      text: text,
                                      date: date,
                                    ),
                                  );
                                }),
                              ),
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
                              top:
                                  BorderSide(width: 1.0, color: Colors.black12),
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
                      ),
                    );
                  })
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      )),
    );
  }

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

  Future<ImageData> getImageData() async {
    return await _db.imageDao.getImage(widget.pageId);
  }

  Future<List<CommentData>> getComments() async {
    return await _db.commentDao.getComments(_imageData.id!);
  }

  Future<void> _showAlertDialog(int commentId, int imageId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GetBuilder<CommentController>(builder: (commentController) {
          return AlertDialog(
            title: const Text('Delete comment'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Are you sure you want to delete the comment?'),
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
                  commentController.deleteComment(commentId, imageId);
                  Get.find<CommentController>().getCommentList(imageId);
                },
              ),
            ],
          );
        });
      },
    );
  }
}
