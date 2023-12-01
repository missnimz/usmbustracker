class WeeklyDistance {
  double? distance;
  int? vesselId;
  int? weekId;

  WeeklyDistance({this.distance, this.vesselId, this.weekId});

  WeeklyDistance.fromJson(Map<String, dynamic> json) {
    distance = json['Distance'];
    vesselId = json['Vessel_id'];
    weekId = json['Week_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Distance'] = distance;
    data['Vessel_id'] = vesselId;
    data['Week_id'] = weekId;
    return data;
  }
}

