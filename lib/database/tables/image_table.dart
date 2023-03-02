import 'package:drift/drift.dart';

class Image extends Table {
  IntColumn get id => integer()();
  TextColumn get base64Image => text()();
  TextColumn get url => text()();
  IntColumn get date => integer()();
  RealColumn get lat => real()();
  RealColumn get lng => real()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'images';
}
