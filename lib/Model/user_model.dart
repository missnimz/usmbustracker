class UserInfo {
  List<Sensor>? sensor;
  User? user;
  List<Vessel>? vessel;
  List<Post>? post;

  UserInfo({this.sensor, this.user, this.vessel});

  UserInfo.fromJson(Map<String, dynamic> json) {
    if (json['sensor'] != null) {
      sensor = [];
      json['sensor'].forEach((v) {
        sensor!.add(Sensor.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['vessel'] != null) {
      vessel = [];
      json['vessel'].forEach((v) {
        vessel!.add(Vessel.fromJson(v));
      });
    }
    if (json['post'] != null) {
      post = [];
      json['post'].forEach((v) {
        post!.add(Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sensor != null) {
      data['sensor'] = sensor!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (vessel != null) {
      data['vessel'] = vessel!.map((v) => v.toJson()).toList();
    }
    if (post != null) {
      data['post'] = post!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sensor {
  String? additionalInfo;
  int? attachedToVesselId;
  String? brand;
  String? createdAt;
  String? eui;
  int? id;
  String? name;
  String? updatedAt;

  Sensor(
      {this.additionalInfo,
      this.attachedToVesselId,
      this.brand,
      this.createdAt,
      this.eui,
      this.id,
      this.name,
      this.updatedAt});

  Sensor.fromJson(Map<String, dynamic> json) {
    additionalInfo = json['additional_info'];
    attachedToVesselId = json['attached_to_vessel_id'];
    brand = json['brand'];
    createdAt = json['created_at'];
    eui = json['eui'];
    id = json['id'];
    name = json['name'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['additional_info'] = additionalInfo;
    data['attached_to_vessel_id'] = attachedToVesselId;
    data['brand'] = brand;
    data['created_at'] = createdAt;
    data['eui'] = eui;
    data['id'] = id;
    data['name'] = name;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class User {
  String? address;
  String? createdAt;
  String? icNumber;
  int? id;
  String? name;
  String? phone;
  String? role;
  String? updatedAt;
  String? profileImage;
  String? email;

  User(
      {this.address,
      this.createdAt,
      this.icNumber,
      this.id,
      this.name,
      this.phone,
      this.role,
      this.updatedAt,
      this.profileImage,
      this.email});

  User.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    createdAt = json['created_at'];
    icNumber = json['ic_number'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
    updatedAt = json['updated_at'];
    profileImage = json['profileImage'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['created_at'] = createdAt;
    data['ic_number'] = icNumber;
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['role'] = role;
    data['updated_at'] = updatedAt;
    data['profileImage'] = profileImage;
    data['email'] = email;
    return data;
  }
}

class Vessel {
  String? areaOfOperation;
  String? baseAdditional;
  String? baseMain;
  int? captainId;
  String? createdAt;
  String? engineBrand;
  int? engineHorsePower;
  String? engineModel;
  String? engineNumber;
  String? fishingGearAdditional;
  String? fishingGearMain;
  int? id;
  String? licenseIssuanceDate;
  String?licenseValidUntilDate;
  int? numOfCrews;
  String? originalRegistrationDate;
  int? ownerId;
  double? siteLocationLat;
  double? siteLocationLng;
  String? updatedAt;
  String? vesselPictureURL;
  double? vesselDepth;
  double? vesselGrt;
  double? vesselLength;
  String? vesselMaterial;
  String? vesselNumber;
  String? vesselType;
  double? vesselWidth;
  double? waterDepth;

  Vessel(
      {this.areaOfOperation,
      this.baseAdditional,
      this.baseMain,
      this.captainId,
      this.createdAt,
      this.engineBrand,
      this.engineHorsePower,
      this.engineModel,
      this.engineNumber,
      this.fishingGearAdditional,
      this.fishingGearMain,
      this.id,
      this.licenseIssuanceDate,
      this.licenseValidUntilDate,
      this.numOfCrews,
      this.originalRegistrationDate,
      this.ownerId,
      this.siteLocationLat,
      this.siteLocationLng,
      this.updatedAt,
      this.vesselPictureURL,
      this.vesselDepth,
      this.vesselGrt,
      this.vesselLength,
      this.vesselMaterial,
      this.vesselNumber,
      this.vesselType,
      this.vesselWidth,
      this.waterDepth});

  Vessel.fromJson(Map<String, dynamic> json) {
    areaOfOperation = json['area_of_operation'];
    baseAdditional = json['base_additional'];
    baseMain = json['base_main'];
    captainId = json['captain_id'];
    createdAt = json['created_at'];
    engineBrand = json['engine_brand'];
    engineHorsePower = json['engine_horse_power'];
    engineModel = json['engine_model'];
    engineNumber = json['engine_number'];
    fishingGearAdditional = json['fishing_gear_additional'];
    fishingGearMain = json['fishing_gear_main'];
    id = json['id'];
    licenseIssuanceDate = json['license_issuance_date'];
    licenseValidUntilDate = json['license_valid_until_date'];
    numOfCrews = json['num_of_crews'];
    originalRegistrationDate = json['original_registration_date'];
    ownerId = json['owner_id'];
    siteLocationLat = json['site_location_lat'];
    siteLocationLng = json['site_location_lng'];
    updatedAt = json['updated_at'];
    vesselPictureURL = json['vesselPictureURL'];
    vesselDepth = json['vessel_depth'];
    vesselGrt = json['vessel_grt'];
    vesselLength = json['vessel_length'];
    vesselMaterial = json['vessel_material'];
    vesselNumber = json['vessel_number'];
    vesselType = json['vessel_type'];
    vesselWidth = json['vessel_width'];
    waterDepth = json['water_depth'] +.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area_of_operation'] = areaOfOperation;
    data['base_additional'] = baseAdditional;
    data['base_main'] = baseMain;
    data['captain_id'] = captainId;
    data['created_at'] = createdAt;
    data['engine_brand'] = engineBrand;
    data['engine_horse_power'] = engineHorsePower;
    data['engine_model'] = engineModel;
    data['engine_number'] = engineNumber;
    data['fishing_gear_additional'] = fishingGearAdditional;
    data['fishing_gear_main'] = fishingGearMain;
    data['id'] = id;
    data['license_issuance_date'] = licenseIssuanceDate;
    data['license_valid_until_date'] = licenseValidUntilDate;
    data['num_of_crews'] = numOfCrews;
    data['original_registration_date'] = originalRegistrationDate;
    data['owner_id'] = ownerId;
    data['site_location_lat'] = siteLocationLat;
    data['site_location_lng'] = siteLocationLng;
    data['updated_at'] = updatedAt;
    data['vesselPictureURL'] = vesselPictureURL;
    data['vessel_depth'] = vesselDepth;
    data['vessel_grt'] = vesselGrt;
    data['vessel_length'] = vesselLength;
    data['vessel_material'] = vesselMaterial;
    data['vessel_number'] = vesselNumber;
    data['vessel_type'] = vesselType;
    data['vessel_width'] = vesselWidth;
    data['water_depth'] = waterDepth;
    return data;
  }
}

class Post{
  int? id;
  String? image_url;
  String? uploaded_at;
  int? user_id;

  Post({
    this.id,
    this.image_url,
    this.uploaded_at,
    this.user_id
  });

  Post.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image_url = json['image_url'];
    uploaded_at = json['uploaded_at'];
    user_id = json['user_id'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = image_url;
    data['uploaded_at'] = uploaded_at;
    data['user_id'] = user_id;
    return data;
  }
}
