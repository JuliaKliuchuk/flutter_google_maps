class CommentModel {
  int? id;
  int? date;
  String? text;

  CommentModel({
    this.id,
    this.date,
    this.text,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}

class Comment {
  late List<CommentModel> _comments;
  List<CommentModel> get comments => _comments;

  Comment({required comments}) {
    comments = comments;
  }

  Comment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _comments = <CommentModel>[];
      json['data'].forEach((el) {
        _comments.add(CommentModel.fromJson(el));
      });
    } else {
      _comments = <CommentModel>[];
    }
  }
}
