class MonthlyDistance {
  double? distance;
  int? vesselID;
  int? month;
  int? year;

  MonthlyDistance({this.distance, this.vesselID, this.month, this.year});

  MonthlyDistance.fromJson(Map<String, dynamic> json) {
    distance = json['Distance'];
    vesselID = json['Vessel ID'];
    month = json['month'];
    year = json['yaer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Distance'] = distance;
    data['Vessel_id'] = vesselID;
    data['month'] = month;
    data['year'] = year;
    return data;
  }
}
