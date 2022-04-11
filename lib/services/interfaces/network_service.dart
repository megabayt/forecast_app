import 'package:forecast_app/interfaces/common_info.dart';
import 'package:geolocator/geolocator.dart';

abstract class NetworkService {
  Future<CommonInfo> getCommonInfo({
    required int height,
    required String distanceUnit,
    required Position position,
  });
}
