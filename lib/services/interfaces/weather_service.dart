import 'package:forecast_app/interfaces/weather_info.dart';

abstract class WeatherService {
  Future<WeatherInfo> getWeatherInfo();
}
