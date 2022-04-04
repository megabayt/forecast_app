import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:forecast_app/interfaces/common_info.dart';
import 'package:forecast_app/services/interfaces/network_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkServiceImpl implements NetworkService {
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
    int? windSpeedHeight,
    int? windGustsHeight,
    int? windDirectionHeight,
    bool? temperature,
    bool? precipitation,
    bool? weatherSymbol,
    bool? sunrise,
    bool? sunset,
  }) {
    final params = [];

    if (windSpeedHeight != null) {
      params.add('wind_speed_${windSpeedHeight}m:ms');
    }
    if (windDirectionHeight != null) {
      params.add('wind_dir_${windDirectionHeight}m:d');
    }
    if (windGustsHeight != null) {
      params.add('wind_gusts_${windGustsHeight}m:ms');
    }
    if (temperature != null && temperature) {
      params.add('t_0m:C');
    }
    if (precipitation != null && precipitation) {
      params.add('precip_1h:mm');
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

    final paramsStr = params.join(',');

    return '/$timestamp/$paramsStr/$latitude,$longitude/json?model=mix';
  }

  @override
  Future<CommonInfo> getCommonInfo() async {
    final login = dotenv.env['LOGIN'];
    final password = dotenv.env['PASSWORD'];
    final base64Str = base64Encode(utf8.encode('$login:$password'));

    try {
      final position = await _determinePosition();

      final now = DateTime.now();
      var timestamp = now.toIso8601String().split('.')[0];
      final tzOffset = now.timeZoneOffset.toString().split(':');

      timestamp += '.000+${tzOffset[0].padLeft(2, '0')}:${tzOffset[1]}';

      final url = _generateUrl(
        timestamp: timestamp,
        latitude: position.latitude,
        longitude: position.longitude,
        windSpeedHeight: 100,
        windGustsHeight: 100,
        windDirectionHeight: 100,
        temperature: true,
        precipitation: true,
        weatherSymbol: true,
        sunrise: true,
        sunset: true,
      );

      final response = await http.get(
          Uri.https(
            'api.meteomatics.com',
            url,
          ),
          headers: {'Authorization': 'Basic $base64Str'});

      Map<String, dynamic> responseBody = json.decode(response.body);

      return CommonInfo.fromJson(responseBody);
    } catch (e) {
      return CommonInfo.fromJson({});
    }
  }
}
