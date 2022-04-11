import 'dart:convert';

List<SatellitesAbove> satellitesAboveFromJson(String str) =>
    List<SatellitesAbove>.from(
        json.decode(str).map((x) => SatellitesAbove.fromJson(x)));

String satellitesAboveToJson(List<SatellitesAbove> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SatellitesAbove {
  SatellitesAbove({
    required this.pnr,
    required this.azimuth,
    required this.elevation,
  });

  final String pnr;
  final double azimuth;
  final double elevation;

  SatellitesAbove copyWith({
    String? pnr,
    double? azimuth,
    double? elevation,
  }) =>
      SatellitesAbove(
        pnr: pnr ?? this.pnr,
        azimuth: azimuth ?? this.azimuth,
        elevation: elevation ?? this.elevation,
      );

  factory SatellitesAbove.fromJson(Map<String, dynamic> json) =>
      SatellitesAbove(
        pnr: json["pnr"],
        azimuth: json["azimuth"].toDouble(),
        elevation: json["elevation"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "pnr": pnr,
        "azimuth": azimuth,
        "elevation": elevation,
      };
}
