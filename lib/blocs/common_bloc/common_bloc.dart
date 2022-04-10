import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:forecast_app/cubits/cloudiness_cubit/cloudiness_cubit.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/cubits/precipitation_cubit/precipitation_cubit.dart';
import 'package:forecast_app/cubits/visibility_cubit/visibility_cubit.dart';
import 'package:forecast_app/cubits/wind_cubit/wind_cubit.dart';
import 'package:forecast_app/cubits/sun_cubit/sun_cubit.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';
import 'package:forecast_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/services/interfaces/network_service.dart';
import 'package:forecast_app/services/service_locator.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

part 'common_bloc.g.dart';
part 'common_event.dart';
part 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  final NetworkService _networkService = locator<NetworkService>();
  final WeatherCubit _weatherCubit;
  final SunCubit _sunCubit;
  final TemperatureCubit _temperatureCubit;
  final WindCubit _windCubit;
  final PrecipitationCubit _precipitationCubit;
  final CloudinessCubit _cloudinessCubit;
  final VisibilityCubit _visibilityCubit;
  final CommonSettingsCubit _commonSettingsCubit;

  CommonBloc({
    required WeatherCubit weatherCubit,
    required SunCubit sunCubit,
    required WindCubit windCubit,
    required TemperatureCubit temperatureCubit,
    required PrecipitationCubit precipitationCubit,
    required CloudinessCubit cloudinessCubit,
    required VisibilityCubit visibilityCubit,
    required CommonSettingsCubit commonSettingsCubit,
  })  : _weatherCubit = weatherCubit,
        _sunCubit = sunCubit,
        _temperatureCubit = temperatureCubit,
        _windCubit = windCubit,
        _precipitationCubit = precipitationCubit,
        _cloudinessCubit = cloudinessCubit,
        _visibilityCubit = visibilityCubit,
        _commonSettingsCubit = commonSettingsCubit,
        super(const CommonState()) {
    on<FetchAll>(
      _onWeatherFetch,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void _onWeatherFetch(
    FetchAll event,
    Emitter<CommonState> emit,
  ) async {
    emit(state.copyWith(
      isFetching: true,
      error: '',
    ));

    try {
      final height = _commonSettingsCubit.state.height.floor();
      final distanceUnitStr =
          _commonSettingsCubit.state.distanceUnit == DistanceUnit.meters
              ? 'm'
              : 'ft';

      final result = await _networkService.getCommonInfo(
        height: height,
        distanceUnit: distanceUnitStr,
      );

      final weatherSymbol =
          result.getValueByParameter('weather_symbol_30min:idx');
      if (weatherSymbol != null) {
        _weatherCubit.onValue(weatherSymbol);
      }

      final sunrise = result.getValueByParameter('sunrise:sql');
      final sunset = result.getValueByParameter('sunset:sql');
      if (sunrise != null && sunset != null) {
        _sunCubit.onValue(
          sunrise: sunrise,
          sunset: sunset,
        );
      }

      final temperature =
          result.getValueByParameter('t_$height$distanceUnitStr:C');
      if (temperature != null) {
        _temperatureCubit.onValue(temperature);
      }

      final windSpeed =
          result.getValueByParameter('wind_speed_$height$distanceUnitStr:ms');
      if (windSpeed != null) {
        _windCubit.onChangeSpeed(windSpeed);
      }

      final windGusts =
          result.getValueByParameter('wind_gusts_$height$distanceUnitStr:ms');
      if (windGusts != null) {
        _windCubit.onChangeGusts(windGusts);
      }

      final windDirection =
          result.getValueByParameter('wind_dir_$height$distanceUnitStr:d');
      if (windDirection != null) {
        _windCubit.onChangeDirection(windDirection);
      }

      final precipitation = result.getValueByParameter('precip_1h:mm');
      if (precipitation != null) {
        _precipitationCubit.onValue(precipitation);
      }

      final cloudiness = result.getValueByParameter('total_cloud_cover:p');
      if (cloudiness != null) {
        _cloudinessCubit.onValue(cloudiness);
      }

      final visibility =
          result.getValueByParameter('visibility:$distanceUnitStr');
      if (visibility != null) {
        _visibilityCubit.onValue(visibility);
      }
    } catch (_) {}
    emit(state.copyWith(
      isFetching: false,
    ));
  }
}

//Debounce query requests
EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) {
    return events.debounce(duration).switchMap(mapper);
  };
}
