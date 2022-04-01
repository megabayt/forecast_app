import 'package:get_it/get_it.dart';
import 'package:forecast_app/services/interfaces/weather_service.dart';
import 'package:forecast_app/services/weather_service_impl.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<WeatherService>(() => WeatherServiceImpl());
}
