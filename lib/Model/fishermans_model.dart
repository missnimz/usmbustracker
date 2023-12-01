class UserList {
  List<Data>? data;
  Meta? meta;

  UserList({this.data, this.meta});

  UserList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? icNumber;
  String? phone;
  String? address;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? profileImage;

  Data(
      {this.id,
      this.name,
      this.icNumber,
      this.phone,
      this.address,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icNumber = json['ic_number'];
    phone = json['phone'];
    address = json['address'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['ic_number'] = icNumber;
    data['phone'] = phone;
    data['address'] = address;
    data['role'] = role;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['profileImage'] = profileImage;
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
