class ImageModel {
  int? id;
  String? base64Image;
  String? url;
  dynamic date;
  double? lat;
  double? lng;

  ImageModel({
    this.id,
    this.url,
    this.base64Image,
    this.date,
    this.lat,
    this.lng,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    date = json['date'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, Object?> toJson() {
    final Map<String, Object?> data = <String, dynamic>{};
    data['base64Image'] = base64Image;
    data['date'] = date;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Image {
  late List<ImageModel> _images;
  List<ImageModel> get images => _images;

  Image({required images}) {
    images = images;
  }

  Image.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _images = <ImageModel>[];
      json['data'].forEach((el) {
        _images.add(ImageModel.fromJson(el));
      });
    } else {
      _images = <ImageModel>[];
    }
  }
}
