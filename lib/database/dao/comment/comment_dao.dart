import 'package:drift/drift.dart';
import 'package:flutter_google_maps/database/database.dart';
import 'package:flutter_google_maps/database/tables/comment_table.dart';

part 'comment_dao.g.dart';

@DriftAccessor(tables: [Comment])
class CommentDao extends DatabaseAccessor<Database> {
  CommentDao(Database db) : super(db);

  // get comments list
  Future<List<CommentData>> getComments(int imageId) {
    return (select(db.comment)..where((tbl) => tbl.imageId.equals(imageId)))
        .get();
  }

  Future createOrUpdateComment(CommentCompanion commentData) {
    return into(db.comment).insertOnConflictUpdate(commentData);
  }

// add comment
  Future<int> insertComment(CommentCompanion commentData) async {
    return await into(db.comment).insert(commentData);
  }

  // delete comment
  Future<int> deleteComment(int commentId) async {
    return await (delete(db.comment)..where((tbl) => tbl.id.equals(commentId)))
        .go();
  }
}
