import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../data/repository/comment_repo.dart';
import '../models/comment_model.dart';

class CommentController extends GetxController {
  final CommentRepo commentRepo;

  CommentController({required this.commentRepo});

  late int _imageId;
  int get imageId => _imageId;

  late List<CommentModel> _commentList = [];
  List<CommentModel> get commentList => _commentList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  late CommentModel _commentData;
  CommentModel get commentData => _commentData;

  setImgId(int imageId) {
    _imageId = imageId;
  }

  Future<void> getCommentList(int imageId) async {
    // update();

    Response response = await commentRepo.getCommentList(imageId);

    log('CommentController response ----${response.body}');

    if (response.statusCode == 200) {
      _commentList = [];
      _commentList.addAll(Comment.fromJson(response.body).comments);

      _isLoaded = true;
      update();
    }
  }

  String convertDate(int date) {
    DateTime dataTime = DateTime.fromMillisecondsSinceEpoch(date);
    var result = DateFormat('dd-MM-yyyy').format(dataTime);

    return result;
  }

  Future<Response> postComment(String comment, int imageId) async {
    return await commentRepo.postComment(comment, imageId);
  }

  // Future<Response> deleteComment(int commentId, int imageId) async {
  //   return await commentRepo.deleteComment(commentId, imageId);
  // }
}
