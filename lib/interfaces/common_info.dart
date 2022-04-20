import 'dart:convert';
import 'dart:core';

CommonInfo commonInfoFromJson(String str) =>
    CommonInfo.fromJson(json.decode(str));

String commonInfoToJson(CommonInfo data) => json.encode(data.toJson());

class CommonInfo {
  CommonInfo({
    required this.version,
    required this.user,
    required this.dateGenerated,
    required this.status,
    required this.data,
  });

  final String version;
  final String user;
  final DateTime dateGenerated;
  final String status;
  final List<Datum> data;

  CommonInfo mergeWith(CommonInfo other) {
    return copyWith(
      data: [...data, ...other.data],
    );
  }

  CommonInfo copyWith({
    String? version,
    String? user,
    DateTime? dateGenerated,
    String? status,
    List<Datum>? data,
  }) =>
      CommonInfo(
        version: version ?? this.version,
        user: user ?? this.user,
        dateGenerated: dateGenerated ?? this.dateGenerated,
        status: status ?? this.status,
        data: data ?? this.data,
      );

  Map<String, dynamic> getValueByParameter(String parameter) {
    try {
      return data
          .firstWhere(
            (element) => element.parameter == parameter,
          )
          .coordinates
          .first
          .dates;
    } catch (e) {
      return {};
    }
  }

  factory CommonInfo.fromJson(Map<String, dynamic> json) => CommonInfo(
        version: json["version"],
        user: json["user"],
        dateGenerated: DateTime.parse(json["dateGenerated"]),
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "user": user,
        "dateGenerated": dateGenerated.toIso8601String(),
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.parameter,
    required this.coordinates,
  });

  final String parameter;
  final List<Coordinate> coordinates;

  Datum copyWith({
    String? parameter,
    List<Coordinate>? coordinates,
  }) =>
      Datum(
        parameter: parameter ?? this.parameter,
        coordinates: coordinates ?? this.coordinates,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        parameter: json["parameter"],
        coordinates: List<Coordinate>.from(
            json["coordinates"].map((x) => Coordinate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "parameter": parameter,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x.toJson())),
      };
}

class Coordinate {
  Coordinate({
    required this.lat,
    required this.lon,
    required this.dates,
  });

  final double lat;
  final double lon;
  final Map<String, dynamic> dates;

  Coordinate copyWith({
    double? lat,
    double? lon,
    Map<String, dynamic>? dates,
  }) =>
      Coordinate(
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        dates: dates ?? this.dates,
      );

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    final dates = <String, dynamic>{};
    json["dates"].forEach((date) {
      dates[date['date']] = date['value'];
    });
    return Coordinate(
      lat: json["lat"].toDouble(),
      lon: json["lon"].toDouble(),
      dates: dates,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lon": lon,
      "dates": dates,
    };
  }
}
