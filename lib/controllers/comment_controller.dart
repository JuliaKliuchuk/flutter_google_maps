import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;

import 'package:flutter_google_maps/database/database.dart';
import '../data/repository/comment_repo.dart';
import '../models/comment_model.dart';

class CommentController extends GetxController {
  final CommentRepo commentRepo;
  final Database db;

  CommentController({
    required this.db,
    required this.commentRepo,
  });

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
    update();

    Response response = await commentRepo.getCommentList(imageId);

    if (response.statusCode == 200) {
      _commentList = [];
      _commentList.addAll(Comment.fromJson(response.body).comments);

      for (var data in _commentList) {
        db.commentDao.createOrUpdateComment(
          CommentCompanion(
            id: drift.Value(data.id!),
            imageId: drift.Value(imageId),
            date: drift.Value(data.date!),
            textComment: drift.Value(data.text!),
          ),
        );
      }

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

  Future<Response> deleteComment(int commentId, int imageId) async {
    return await commentRepo.deleteComment(commentId, imageId);
  }
}
