
const String tableSpot = 'spots';

class SpotFields {
  static final List<String> values = [
    /// Add all fields
    id, name, longitude, latitude, time
  ];
  static const String id ='_id';
  static const String name = 'name';
  static const String longitude = 'longitude';
  static const String latitude = 'latitude';
  static const String time = 'time';
}

class Spot {

  final int? id;
  final String name;
  final double longitude;
  final double latitude;
  final DateTime createdTime;

  const Spot({
    this.id,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.createdTime,
  });

  Spot copy({
    int? id,
    String? name,
    double? longitude,
    double? latitude,
    DateTime? createdTime,
  }) => Spot(
        id: id ?? this.id,
        name: name ?? this.name,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        createdTime: createdTime ?? this.createdTime,
      );
  static Spot fromJson(Map<String, Object?> json) => Spot(
        id: json[SpotFields.id] as int?,
        name: json[SpotFields.name] as String,
        longitude: json[SpotFields.longitude] as double,
        latitude: json[SpotFields.latitude] as double,
        createdTime: DateTime.parse(json[SpotFields.time] as String),
      );



  Map<String, Object?> toJson()=>{
    SpotFields.id : id,
    SpotFields.name : name,
    SpotFields.longitude : longitude,
    SpotFields.latitude : latitude,
    SpotFields.time : createdTime.toIso8601String(),
  };
}
