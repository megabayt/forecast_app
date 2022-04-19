import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:forecast_app/interfaces/common_info.dart';
import 'package:forecast_app/services/interfaces/network_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class NetworkServiceImpl implements NetworkService {
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
    required Point point,
  }) async {
    final login = dotenv.env['LOGIN'];
    final password = dotenv.env['PASSWORD'];
    final base64Str = base64Encode(utf8.encode('$login:$password'));

    try {
      var now = DateTime.now();
      now = DateTime(now.year, now.month, now.day);
      var timestampNow = now.toIso8601String().split('.')[0];
      final tzOffsetNow = now.timeZoneOffset.toString().split(':');
      timestampNow +=
          '.000+${tzOffsetNow[0].padLeft(2, '0')}:${tzOffsetNow[1]}';

      final timestampPlusWeek =
          now.add(const Duration(days: 7)).toIso8601String().split('.')[0] +
              '.000+${tzOffsetNow[0].padLeft(2, '0')}:${tzOffsetNow[1]}';
      final resultTimestampPlusWeek = '$timestampNow--$timestampPlusWeek:PT5M';

      final timestampPlusTwoDays =
          now.add(const Duration(days: 2)).toIso8601String().split('.')[0] +
              '.000+${tzOffsetNow[0].padLeft(2, '0')}:${tzOffsetNow[1]}';
      final resultTimestampPlusTwoDays = '$timestampNow--$timestampPlusTwoDays:PT5M';

      final commonArguments = {
        const Symbol('timestamp'): resultTimestampPlusWeek,
        const Symbol('latitude'): point.latitude,
        const Symbol('longitude'): point.longitude,
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
        const Symbol('sunrise'): true,
        const Symbol('sunset'): true,
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
        const Symbol('timestamp'): resultTimestampPlusTwoDays,
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

      return response1Body.mergeWith(response2Body);
    } catch (e) {
      return CommonInfo.fromJson({});
    }
  }
}
