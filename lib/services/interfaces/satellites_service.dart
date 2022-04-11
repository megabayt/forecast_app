import 'package:forecast_app/interfaces/satellites_above.dart';

abstract class SatellitesService {
  Future<void> load();

  Future<List<SatellitesAbove>> getSattelitesAbove({
    required double latitude,
    required double longitude,
  });
}
