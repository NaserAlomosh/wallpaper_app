class PhotoModel {
  List<dynamic>? photos;
  String? alt;
  PhotoModel({this.photos, this.alt});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      photos: json['photos'],
      alt: json['alt'],
    );
  }
}

class Photos {
  int? id;
  Src? src;
  String? photographer;
  String? url;
  String? alt;

  Photos({
    this.id,
    this.src,
    this.photographer,
    this.url,
    this.alt,
  });

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      id: json['id'],
      src: json['src'] != null ? Src.fromJson(json['src']) : null,
      photographer: json['photographer'],
      url: json['url'],
      alt: json['alt'],
    );
  }
}

class Src {
  String? alt;
  String? medium;

  Src({this.medium, String? alt});

  factory Src.fromJson(Map<String, dynamic> json) {
    return Src(
      medium: json['medium'],
      alt: json['alt'],
    );
  }
}
