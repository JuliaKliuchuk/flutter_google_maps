// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ImageTable extends Image with TableInfo<$ImageTable, ImageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImageTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _base64ImageMeta =
      const VerificationMeta('base64Image');
  @override
  late final GeneratedColumn<String> base64Image = GeneratedColumn<String>(
      'base64_image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
      'date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
      'lat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
      'lng', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, base64Image, url, date, lat, lng];
  @override
  String get aliasedName => _alias ?? 'images';
  @override
  String get actualTableName => 'images';
  @override
  VerificationContext validateIntegrity(Insertable<ImageData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('base64_image')) {
      context.handle(
          _base64ImageMeta,
          base64Image.isAcceptableOrUnknown(
              data['base64_image']!, _base64ImageMeta));
    } else if (isInserting) {
      context.missing(_base64ImageMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
          _lngMeta, lng.isAcceptableOrUnknown(data['lng']!, _lngMeta));
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImageData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      base64Image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}base64_image'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date'])!,
      lat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lat'])!,
      lng: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lng'])!,
    );
  }

  @override
  $ImageTable createAlias(String alias) {
    return $ImageTable(attachedDatabase, alias);
  }
}

class ImageData extends DataClass implements Insertable<ImageData> {
  final int? id;
  final String base64Image;
  final String? url;
  final int date;
  final double lat;
  final double lng;
  const ImageData(
      {this.id,
      required this.base64Image,
      this.url,
      required this.date,
      required this.lat,
      required this.lng});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['base64_image'] = Variable<String>(base64Image);
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    map['date'] = Variable<int>(date);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    return map;
  }

  ImageCompanion toCompanion(bool nullToAbsent) {
    return ImageCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      base64Image: Value(base64Image),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      date: Value(date),
      lat: Value(lat),
      lng: Value(lng),
    );
  }

  factory ImageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImageData(
      id: serializer.fromJson<int?>(json['id']),
      base64Image: serializer.fromJson<String>(json['base64Image']),
      url: serializer.fromJson<String?>(json['url']),
      date: serializer.fromJson<int>(json['date']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'base64Image': serializer.toJson<String>(base64Image),
      'url': serializer.toJson<String?>(url),
      'date': serializer.toJson<int>(date),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
    };
  }

  ImageData copyWith(
          {Value<int?> id = const Value.absent(),
          String? base64Image,
          Value<String?> url = const Value.absent(),
          int? date,
          double? lat,
          double? lng}) =>
      ImageData(
        id: id.present ? id.value : this.id,
        base64Image: base64Image ?? this.base64Image,
        url: url.present ? url.value : this.url,
        date: date ?? this.date,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );
  @override
  String toString() {
    return (StringBuffer('ImageData(')
          ..write('id: $id, ')
          ..write('base64Image: $base64Image, ')
          ..write('url: $url, ')
          ..write('date: $date, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, base64Image, url, date, lat, lng);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageData &&
          other.id == this.id &&
          other.base64Image == this.base64Image &&
          other.url == this.url &&
          other.date == this.date &&
          other.lat == this.lat &&
          other.lng == this.lng);
}

class ImageCompanion extends UpdateCompanion<ImageData> {
  final Value<int?> id;
  final Value<String> base64Image;
  final Value<String?> url;
  final Value<int> date;
  final Value<double> lat;
  final Value<double> lng;
  const ImageCompanion({
    this.id = const Value.absent(),
    this.base64Image = const Value.absent(),
    this.url = const Value.absent(),
    this.date = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
  });
  ImageCompanion.insert({
    this.id = const Value.absent(),
    required String base64Image,
    this.url = const Value.absent(),
    required int date,
    required double lat,
    required double lng,
  })  : base64Image = Value(base64Image),
        date = Value(date),
        lat = Value(lat),
        lng = Value(lng);
  static Insertable<ImageData> custom({
    Expression<int>? id,
    Expression<String>? base64Image,
    Expression<String>? url,
    Expression<int>? date,
    Expression<double>? lat,
    Expression<double>? lng,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (base64Image != null) 'base64_image': base64Image,
      if (url != null) 'url': url,
      if (date != null) 'date': date,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
    });
  }

  ImageCompanion copyWith(
      {Value<int?>? id,
      Value<String>? base64Image,
      Value<String?>? url,
      Value<int>? date,
      Value<double>? lat,
      Value<double>? lng}) {
    return ImageCompanion(
      id: id ?? this.id,
      base64Image: base64Image ?? this.base64Image,
      url: url ?? this.url,
      date: date ?? this.date,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (base64Image.present) {
      map['base64_image'] = Variable<String>(base64Image.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageCompanion(')
          ..write('id: $id, ')
          ..write('base64Image: $base64Image, ')
          ..write('url: $url, ')
          ..write('date: $date, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }
}

class $CommentTable extends Comment with TableInfo<$CommentTable, CommentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _imageIdMeta =
      const VerificationMeta('imageId');
  @override
  late final GeneratedColumn<int> imageId = GeneratedColumn<int>(
      'image_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES images (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
      'date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _textCommentMeta =
      const VerificationMeta('textComment');
  @override
  late final GeneratedColumn<String> textComment = GeneratedColumn<String>(
      'text_comment', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, imageId, date, textComment];
  @override
  String get aliasedName => _alias ?? 'comments';
  @override
  String get actualTableName => 'comments';
  @override
  VerificationContext validateIntegrity(Insertable<CommentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('image_id')) {
      context.handle(_imageIdMeta,
          imageId.isAcceptableOrUnknown(data['image_id']!, _imageIdMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('text_comment')) {
      context.handle(
          _textCommentMeta,
          textComment.isAcceptableOrUnknown(
              data['text_comment']!, _textCommentMeta));
    } else if (isInserting) {
      context.missing(_textCommentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommentData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      imageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}image_id']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date'])!,
      textComment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_comment'])!,
    );
  }

  @override
  $CommentTable createAlias(String alias) {
    return $CommentTable(attachedDatabase, alias);
  }
}

class CommentData extends DataClass implements Insertable<CommentData> {
  final int id;
  final int? imageId;
  final int date;
  final String textComment;
  const CommentData(
      {required this.id,
      this.imageId,
      required this.date,
      required this.textComment});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || imageId != null) {
      map['image_id'] = Variable<int>(imageId);
    }
    map['date'] = Variable<int>(date);
    map['text_comment'] = Variable<String>(textComment);
    return map;
  }

  CommentCompanion toCompanion(bool nullToAbsent) {
    return CommentCompanion(
      id: Value(id),
      imageId: imageId == null && nullToAbsent
          ? const Value.absent()
          : Value(imageId),
      date: Value(date),
      textComment: Value(textComment),
    );
  }

  factory CommentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommentData(
      id: serializer.fromJson<int>(json['id']),
      imageId: serializer.fromJson<int?>(json['imageId']),
      date: serializer.fromJson<int>(json['date']),
      textComment: serializer.fromJson<String>(json['textComment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imageId': serializer.toJson<int?>(imageId),
      'date': serializer.toJson<int>(date),
      'textComment': serializer.toJson<String>(textComment),
    };
  }

  CommentData copyWith(
          {int? id,
          Value<int?> imageId = const Value.absent(),
          int? date,
          String? textComment}) =>
      CommentData(
        id: id ?? this.id,
        imageId: imageId.present ? imageId.value : this.imageId,
        date: date ?? this.date,
        textComment: textComment ?? this.textComment,
      );
  @override
  String toString() {
    return (StringBuffer('CommentData(')
          ..write('id: $id, ')
          ..write('imageId: $imageId, ')
          ..write('date: $date, ')
          ..write('textComment: $textComment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imageId, date, textComment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommentData &&
          other.id == this.id &&
          other.imageId == this.imageId &&
          other.date == this.date &&
          other.textComment == this.textComment);
}

class CommentCompanion extends UpdateCompanion<CommentData> {
  final Value<int> id;
  final Value<int?> imageId;
  final Value<int> date;
  final Value<String> textComment;
  const CommentCompanion({
    this.id = const Value.absent(),
    this.imageId = const Value.absent(),
    this.date = const Value.absent(),
    this.textComment = const Value.absent(),
  });
  CommentCompanion.insert({
    this.id = const Value.absent(),
    this.imageId = const Value.absent(),
    required int date,
    required String textComment,
  })  : date = Value(date),
        textComment = Value(textComment);
  static Insertable<CommentData> custom({
    Expression<int>? id,
    Expression<int>? imageId,
    Expression<int>? date,
    Expression<String>? textComment,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageId != null) 'image_id': imageId,
      if (date != null) 'date': date,
      if (textComment != null) 'text_comment': textComment,
    });
  }

  CommentCompanion copyWith(
      {Value<int>? id,
      Value<int?>? imageId,
      Value<int>? date,
      Value<String>? textComment}) {
    return CommentCompanion(
      id: id ?? this.id,
      imageId: imageId ?? this.imageId,
      date: date ?? this.date,
      textComment: textComment ?? this.textComment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imageId.present) {
      map['image_id'] = Variable<int>(imageId.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (textComment.present) {
      map['text_comment'] = Variable<String>(textComment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommentCompanion(')
          ..write('id: $id, ')
          ..write('imageId: $imageId, ')
          ..write('date: $date, ')
          ..write('textComment: $textComment')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $ImageTable image = $ImageTable(this);
  late final $CommentTable comment = $CommentTable(this);
  late final ImageDao imageDao = ImageDao(this as Database);
  late final CommentDao commentDao = CommentDao(this as Database);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [image, comment];
}
