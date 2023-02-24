import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api_client.dart';

class CommentRepo extends GetxService {
  final ApiClient apiClient;

  CommentRepo({
    required this.apiClient,
  });

  Future<Response> getCommentList(int imageId) async {
    return await apiClient
        .getData('${AppConstans.GET_IMAGE_URL}/$imageId/comment?page=0');
  }

  Future<Response> postComment(String comment, int imageId) async {
    return await apiClient.postData(
      '${AppConstans.POST_IMAGE_URL}/$imageId/comment',
      {'text': comment},
    );
  }

  Future<Response> deleteComment(int commentId, int imageId) async {
    return await apiClient.deleteData(
        '${AppConstans.DELETE_IMAGE_URL}$imageId/comment/$commentId');
  }
}
