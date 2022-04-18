import 'package:geolocator/geolocator.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class PositionWithAddress {
  PositionWithAddress({required this.position, this.address});

  factory PositionWithAddress.fromJson(Map<String, dynamic> json) =>
      PositionWithAddress(
        position: Position.fromMap(json['position']),
        address: null,
      );

  Map<String, dynamic> toJson() => {
        'position': position.toJson(),
        'address': null,
      };

  final Position position;
  final Address? address;
}
