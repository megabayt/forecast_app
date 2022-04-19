import 'package:yandex_geocoder/yandex_geocoder.dart';

class PositionWithAddress {
  PositionWithAddress({required this.point, this.address});

  final Point point;
  final Address? address;
}
