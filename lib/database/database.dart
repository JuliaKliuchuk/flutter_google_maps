import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/comment_table.dart';
import 'tables/image_table.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'image.db'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [Image, Comment],
)
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

// IMAGES

// get imagess list
  Future<List<ImageData>> getImages() async {
    return await select(image).get();
  }

  // watch imagess list
  Stream<List<ImageData>> get watchImagesList => select(image).watch();

  // get image
  Future<ImageData> getImage(int imageId) async {
    return await (select(image)..where((tbl) => tbl.id.equals(imageId)))
        .getSingle();
  }

  // add image
  // Future insertImage(ImageCompanion imageData) async {
  //   return await into(image).insert(imageData);
  // }

  Future createOrUpdateUser(ImageCompanion imageData) {
    return into(image).insertOnConflictUpdate(imageData);
  }

// delete image
  Future<int> deleteImage(int imageId) async {
    return await (delete(image)..where((tbl) => tbl.id.equals(imageId))).go();
  }

// COMMENTS

  // get comments list
  Future<SimpleSelectStatement<$CommentTable, CommentData>> getComments(
      int imageId) async {
    return select(comment)..where((tbl) => tbl.imageId.equals(imageId));
  }

// add comment
  Future<int> insertComment(CommentCompanion commentData) async {
    return await into(comment).insert(commentData);
  }

  // delete comment
  Future<int> deleteComment(int commentId) async {
    return await (delete(comment)..where((tbl) => tbl.id.equals(commentId)))
        .go();
  }
}
