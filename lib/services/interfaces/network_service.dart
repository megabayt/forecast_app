import 'package:forecast_app/interfaces/common_info.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

abstract class NetworkService {
  Future<CommonInfo> getCommonInfo({
    required int height,
    required String distanceUnit,
    required Point point,
  });
}
