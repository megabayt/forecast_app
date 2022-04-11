import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class PositionWithPlaceMark {
  PositionWithPlaceMark({required this.position, this.placemark});

  factory PositionWithPlaceMark.fromJson(Map<String, dynamic> json) =>
      PositionWithPlaceMark(
        position: Position.fromMap(json['position']),
        placemark: json['placemark'],
      );

  Map<String, dynamic> toJson() => {
        'position': position.toJson(),
        'placemark': placemark,
      };

  final Position position;
  final Placemark? placemark;
}
