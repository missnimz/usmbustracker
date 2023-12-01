class UserEveryMonthDistance {
  int? count;
  List<Result>? result;

  UserEveryMonthDistance({this.count, this.result});

  UserEveryMonthDistance.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  double? distance;
  int? vesselID;
  int? month;
  int? year;

  Result({this.distance, this.vesselID, this.month, this.year});

  Result.fromJson(Map<String, dynamic> json) {
    distance = json['Distance'];
    vesselID = json['Vessel ID'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Distance'] = distance;
    data['Vessel ID'] = vesselID;
    data['month'] = month;
    data['year'] = year;
    return data;
  }
}
