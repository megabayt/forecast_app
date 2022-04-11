import 'package:forecast_app/interfaces/position_with_placemark.dart';

abstract class GeolocationService {
  Future<PositionWithPlaceMark> getCurrentLocation();
}
