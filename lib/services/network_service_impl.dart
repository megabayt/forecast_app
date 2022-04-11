import 'dart:convert';
import 'package:forecast_app/services/interfaces/satellites_service.dart';
import 'package:forecast_app/services/service_locator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:forecast_app/interfaces/common_info.dart';
import 'package:forecast_app/services/interfaces/network_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkServiceImpl implements NetworkService {
  final SatellitesService _satellitesService = locator<SatellitesService>();

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  String _generateUrl({
    required String timestamp,
    required double latitude,
    required double longitude,
    required int height,
    required String distanceUnit,
    bool? windSpeed,
    bool? windDir,
    bool? windGusts,
    bool? temperature,
    bool? precipitation,
    bool? cloudiness,
    bool? visibility,
    bool? weatherSymbol,
    bool? sunrise,
    bool? sunset,
    bool? kpIndex,
  }) {
    final params = [];

    if (windSpeed != null && windSpeed) {
      params.add('wind_speed_$height$distanceUnit:ms');
    }
    if (windDir != null && windDir) {
      params.add('wind_dir_$height$distanceUnit:d');
    }
    if (windGusts != null && windGusts) {
      params.add('wind_gusts_$height$distanceUnit:ms');
    }
    if (temperature != null && temperature) {
      params.add('t_$height$distanceUnit:C');
    }
    if (precipitation != null && precipitation) {
      params.add('precip_1h:mm');
    }
    if (cloudiness != null && cloudiness) {
      params.add('total_cloud_cover:p');
    }
    if (visibility != null && visibility) {
      params.add('visibility:$distanceUnit');
    }
    if (weatherSymbol != null && weatherSymbol) {
      params.add('weather_symbol_30min:idx');
    }
    if (sunrise != null && sunrise) {
      params.add('sunrise:sql');
    }
    if (sunset != null && sunset) {
      params.add('sunset:sql');
    }
    if (kpIndex != null && kpIndex) {
      params.add('kp:idx');
    }

    final paramsStr = params.join(',');

    return '/$timestamp/$paramsStr/$latitude,$longitude/json?model=mix';
  }

  @override
  Future<CommonInfo> getCommonInfo({
    required int height,
    required String distanceUnit,
  }) async {
    final login = dotenv.env['LOGIN'];
    final password = dotenv.env['PASSWORD'];
    final base64Str = base64Encode(utf8.encode('$login:$password'));

    try {
      final position = await _determinePosition();

      final now = DateTime.now();
      var timestamp = now.toIso8601String().split('.')[0];
      final tzOffset = now.timeZoneOffset.toString().split(':');

      timestamp += '.000+${tzOffset[0].padLeft(2, '0')}:${tzOffset[1]}';

      final commonArguments = {
        const Symbol('timestamp'): timestamp,
        const Symbol('latitude'): position.latitude,
        const Symbol('longitude'): position.longitude,
        const Symbol('height'): height,
        const Symbol('distanceUnit'): distanceUnit,
      };

      final url1 = Function.apply(_generateUrl, [], {
        ...commonArguments,
        const Symbol('windSpeed'): true,
        const Symbol('windDir'): true,
        const Symbol('windGusts'): true,
        const Symbol('temperature'): true,
        const Symbol('precipitation'): true,
        const Symbol('cloudiness'): true,
        const Symbol('visibility'): true,
        const Symbol('weatherSymbol'): true,
      });

      final response1 = await http.get(
          Uri.https(
            'api.meteomatics.com',
            url1,
          ),
          headers: {'Authorization': 'Basic $base64Str'});

      CommonInfo response1Body =
          CommonInfo.fromJson(json.decode(response1.body));

      final url2 = Function.apply(_generateUrl, [], {
        ...commonArguments,
        const Symbol('sunrise'): true,
        const Symbol('sunset'): true,
        const Symbol('kpIndex'): true,
      });

      final response2 = await http.get(
          Uri.https(
            'api.meteomatics.com',
            url2,
          ),
          headers: {'Authorization': 'Basic $base64Str'});

      CommonInfo response2Body =
          CommonInfo.fromJson(json.decode(response2.body));

      await _satellitesService.load();
      await _satellitesService.getSattelitesAbove(
          latitude: position.latitude, longitude: position.longitude);

      return response1Body.mergeWith(response2Body);
    } catch (e) {
      return CommonInfo.fromJson({});
    }
  }
}
