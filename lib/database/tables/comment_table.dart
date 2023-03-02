import 'package:drift/drift.dart';

import 'image_table.dart';

class Comment extends Table {
  IntColumn get id => integer()();
  IntColumn get imageId => integer().nullable().references(Image, #id)();
  IntColumn get date => integer()();
  TextColumn get textComment => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'comments';
}
