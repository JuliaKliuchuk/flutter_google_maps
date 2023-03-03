import 'package:drift/drift.dart';
import 'package:flutter_google_maps/database/database.dart';
import 'package:flutter_google_maps/database/tables/image_table.dart';

part 'image_dao.g.dart';

@DriftAccessor(tables: [Image])
class ImageDao extends DatabaseAccessor<Database> {
  ImageDao(Database db) : super(db);

//   MultiSelectable<T> pagesList<T extends DataClass>([
//     List<OrderingTerm Function(Images)>? orders,
//     int? limit,
//     int? offset,
//   ]) {
//     return (db.select<$ImagesTable, T>(
//         db.images as ResultSetImplementation<$ImagesTable, T>))
//       ..orderBy(orders ?? [])
//       ..limitExpr = (limit != null ? Limit(limit, offset) : null);
//   }
// }

// get imagess list
  Future<List<ImageData>> getImages() async {
    return select(db.image).get();
  }

  // watch imagess list
  Stream<List<ImageData>> get watchImagesList => select(db.image).watch();

  // get image
  Future<ImageData> getImage(int imageId) async {
    return await (select(db.image)..where((tbl) => tbl.id.equals(imageId)))
        .getSingle();
  }

  // add image
  Future insertImage(ImageCompanion imageData) async {
    return await into(db.image).insert(imageData);
  }

  Future createOrUpdateImage(ImageCompanion imageData) {
    return into(db.image).insertOnConflictUpdate(imageData);
  }

// delete image
  Future<int> deleteImage(int imageId) async {
    return await (delete(db.image)..where((tbl) => tbl.id.equals(imageId)))
        .go();
  }
}
