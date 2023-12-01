class SensorList {
  Meta? meta;
  List<UserSensor>? data;

  SensorList({this.meta, this.data});

  SensorList.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(UserSensor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? page;
  int? perPage;
  int? pageCount;
  int? totalCount;

  Meta({this.page, this.perPage, this.pageCount, this.totalCount});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    pageCount = json['page_count'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['page_count'] = pageCount;
    data['total_count'] = totalCount;
    return data;
  }
}

class UserSensor {
  int? id;
  String? name;
  String? eui;
  String? brand;
  int? attachedToVesselId;
  String? additionalInfo;
  String? createdAt;
  String? updatedAt;

  UserSensor(
      {this.id,
      this.name,
      this.eui,
      this.brand,
      this.attachedToVesselId,
      this.additionalInfo,
      this.createdAt,
      this.updatedAt});

  UserSensor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    eui = json['eui'];
    brand = json['brand'];
    attachedToVesselId = json['attached_to_vessel_id'];
    additionalInfo = json['additional_info'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['eui'] = eui;
    data['brand'] = brand;
    data['attached_to_vessel_id'] = attachedToVesselId;
    data['additional_info'] = additionalInfo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
