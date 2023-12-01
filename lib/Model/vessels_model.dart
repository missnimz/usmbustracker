class VesselList {
  Meta? meta;
  List<UserVessel>? data;

  VesselList({this.meta, this.data});

  VesselList.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(UserVessel.fromJson(v));
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

class UserVessel {
  int? id;
  String? vesselPictureURL;
  String? vesselNumber;
  int? ownerId;
  int? captainId;
  int? numOfCrews;
  String? vesselType;
  String? vesselMaterial;
  double? vesselLength;
  double? vesselWidth;
  double? vesselDepth;
  double? vesselGrt;
  String? engineBrand;
  String? engineModel;
  int? engineHorsePower;
  String? engineNumber;
  String? fishingGearMain;
  String? fishingGearAdditional;
  String? baseMain;
  String? baseAdditional;
  String? areaOfOperation;
  String? originalRegistrationDate;
  String? licenseIssuanceDate;
  String? licenseValidUntilDate;
  double? siteLocationLat;
  double? siteLocationLng;
  double? waterDepth;
  String? createdAt;
  String? updatedAt;

  UserVessel(
      {this.id,
      this.vesselPictureURL,
      this.vesselNumber,
      this.ownerId,
      this.captainId,
      this.numOfCrews,
      this.vesselType,
      this.vesselMaterial,
      this.vesselLength,
      this.vesselWidth,
      this.vesselDepth,
      this.vesselGrt,
      this.engineBrand,
      this.engineModel,
      this.engineHorsePower,
      this.engineNumber,
      this.fishingGearMain,
      this.fishingGearAdditional,
      this.baseMain,
      this.baseAdditional,
      this.areaOfOperation,
      this.originalRegistrationDate,
      this.licenseIssuanceDate,
      this.licenseValidUntilDate,
      this.siteLocationLat,
      this.siteLocationLng,
      this.waterDepth,
      this.createdAt,
      this.updatedAt});

  UserVessel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vesselPictureURL = json['VesselPictureURL'];
    vesselNumber = json['vessel_number'];
    ownerId = json['owner_id'];
    captainId = json['captain_id'];
    numOfCrews = json['num_of_crews'];
    vesselType = json['vessel_type'];
    vesselMaterial = json['vessel_material'];
    vesselLength = json['vessel_length'];
    vesselWidth = json['vessel_width'];
    vesselDepth = json['vessel_depth'];
    vesselGrt = json['vessel_grt'];
    engineBrand = json['engine_brand'];
    engineModel = json['engine_model'];
    engineHorsePower = json['engine_horse_power'];
    engineNumber = json['engine_number'];
    fishingGearMain = json['fishing_gear_main'];
    fishingGearAdditional = json['fishing_gear_additional'];
    baseMain = json['base_main'];
    baseAdditional = json['base_additional'];
    areaOfOperation = json['area_of_operation'];
    originalRegistrationDate = json['original_registration_date'];
    licenseIssuanceDate = json['license_issuance_date'];
    licenseValidUntilDate = json['license_valid_until_date'];
    siteLocationLat = json['site_location_lat'];
    siteLocationLng = json['site_location_lng'];
    //waterDepth = json['water_depth'] + .0;
    waterDepth = (json['water_depth'] ?? 0.0) + 0.0;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['VesselPictureURL'] = vesselPictureURL;
    data['vessel_number'] = vesselNumber;
    data['owner_id'] = ownerId;
    data['captain_id'] = captainId;
    data['num_of_crews'] = numOfCrews;
    data['vessel_type'] = vesselType;
    data['vessel_material'] = vesselMaterial;
    data['vessel_length'] = vesselLength;
    data['vessel_width'] = vesselWidth;
    data['vessel_depth'] = vesselDepth;
    data['vessel_grt'] = vesselGrt;
    data['engine_brand'] = engineBrand;
    data['engine_model'] = engineModel;
    data['engine_horse_power'] = engineHorsePower;
    data['engine_number'] = engineNumber;
    data['fishing_gear_main'] = fishingGearMain;
    data['fishing_gear_additional'] = fishingGearAdditional;
    data['base_main'] = baseMain;
    data['base_additional'] = baseAdditional;
    data['area_of_operation'] = areaOfOperation;
    data['original_registration_date'] = originalRegistrationDate;
    data['license_issuance_date'] = licenseIssuanceDate;
    data['license_valid_until_date'] = licenseValidUntilDate;
    data['site_location_lat'] = siteLocationLat;
    data['site_location_lng'] = siteLocationLng;
    data['water_depth'] = waterDepth;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
