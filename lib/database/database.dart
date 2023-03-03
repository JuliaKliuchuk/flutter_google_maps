import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'dao/comment/comment_dao.dart';
import 'dao/image/image_dao.dart';
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
  daos: [ImageDao, CommentDao],
)
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
