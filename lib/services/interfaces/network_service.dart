import 'package:forecast_app/interfaces/common_info.dart';

abstract class NetworkService {
  Future<CommonInfo> getCommonInfo({
    int? temperatureHeight,
    int? windSpeedHeight,
    int? windGustsHeight,
    int? windDirectionHeight,
    bool? precipitation,
    bool? weatherSymbol,
    bool? sunrise,
    bool? sunset,
  });
}
