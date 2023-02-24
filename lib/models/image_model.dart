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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base64Image'] = base64Image;
    data['date'] = date;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Images {
  late List<ImageModel> _images;
  List<ImageModel> get images => _images;

  Images({required images}) {
    images = images;
  }

  Images.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _images = <ImageModel>[];
      json['data'].forEach((v) {
        _images.add(ImageModel.fromJson(v));
      });
    } else {
      _images = <ImageModel>[];
    }
  }
}
