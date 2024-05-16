class GalleryResponse {
  GalleryResponse({
    this.status,
    this.data,
    this.message,
  });

  GalleryResponse.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
  String? status;
  Data? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    return map;
  }
}

class Data {
  Data({
    this.images,
  });

  Data.fromJson(dynamic json) {
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  List<String>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['images'] = images;
    return map;
  }
}
