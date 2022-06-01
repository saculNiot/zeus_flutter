class SavePhoto {
  String? userId;
  String? groupId;
  String? phPlatform;
  String? phModel;
  String? phId;
  String? phBrand;
  String? longitude;
  String? latitude;
  String? photos;

  SavePhoto({
    this.userId,
    this.groupId,
    this.phPlatform,
    this.phModel,
    this.phId,
    this.phBrand,
    this.longitude,
    this.latitude,
    this.photos,
  });

  SavePhoto.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    groupId = json['groupId'];
    phPlatform = json['ph_platform'];
    phModel = json['ph_model'];
    phId = json['ph_id'];
    phBrand = json['ph_brand'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    photos = json['photos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['groupId'] = this.groupId;
    data['phPlatform'] = this.phPlatform;
    data['phModel'] = this.phModel;
    data['phId'] = this.phId;
    data['phBrand'] = this.phBrand;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['photos'] = this.photos;

    return data;
  }
}