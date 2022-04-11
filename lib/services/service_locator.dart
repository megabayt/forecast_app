import 'package:forecast_app/services/interfaces/satellites_service.dart';
import 'package:forecast_app/services/satellites_service_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:forecast_app/services/interfaces/network_service.dart';
import 'package:forecast_app/services/network_service_impl.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<NetworkService>(() => NetworkServiceImpl());
  locator.registerLazySingleton<SatellitesService>(() => SatellitesServiceImpl());
}
