import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:forecast_app/cubits/cloudiness_cubit/cloudiness_cubit.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/cubits/kpindex_cubit/kpindex_cubit.dart';
import 'package:forecast_app/cubits/precipitation_cubit/precipitation_cubit.dart';
import 'package:forecast_app/cubits/visibility_cubit/visibility_cubit.dart';
import 'package:forecast_app/cubits/wind_cubit/wind_cubit.dart';
import 'package:forecast_app/cubits/sun_cubit/sun_cubit.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';
import 'package:forecast_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/services/interfaces/network_service.dart';
import 'package:forecast_app/services/service_locator.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';
import 'package:meta/meta.dart';

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
  final KpIndexCubit _kpIndexCubit;
  final CommonSettingsCubit _commonSettingsCubit;

  CommonBloc({
    required WeatherCubit weatherCubit,
    required SunCubit sunCubit,
    required WindCubit windCubit,
    required TemperatureCubit temperatureCubit,
    required PrecipitationCubit precipitationCubit,
    required CloudinessCubit cloudinessCubit,
    required VisibilityCubit visibilityCubit,
    required KpIndexCubit kpIndexCubit,
    required CommonSettingsCubit commonSettingsCubit,
  })  : _weatherCubit = weatherCubit,
        _sunCubit = sunCubit,
        _temperatureCubit = temperatureCubit,
        _windCubit = windCubit,
        _precipitationCubit = precipitationCubit,
        _cloudinessCubit = cloudinessCubit,
        _visibilityCubit = visibilityCubit,
        _kpIndexCubit = kpIndexCubit,
        _commonSettingsCubit = commonSettingsCubit,
        super(const CommonState()) {
    on<FetchAll>(
      _onFetchAll,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  int get height {
    return _commonSettingsCubit.state.height.floor();
  }

  String get distanceUnitStr {
    return _commonSettingsCubit.state.distanceUnit == DistanceUnit.meters
        ? 'm'
        : 'ft';
  }

  void _onFetchAll(
    FetchAll event,
    Emitter<CommonState> emit,
  ) async {
    emit(state.copyWith(
      isFetching: true,
      error: '',
    ));

    try {
      final result = await _networkService.getCommonInfo(
        height: height,
        distanceUnit: distanceUnitStr,
        point: event.point,
      );

      final weatherSymbol =
          result.getValueByParameter('weather_symbol_30min:idx');
      _weatherCubit.onData(weatherSymbol);

      final sunrise = result.getValueByParameter('sunrise:sql');
      final sunset = result.getValueByParameter('sunset:sql');
      _sunCubit.onData(
        sunrise: sunrise,
        sunset: sunset,
      );

      final temperature =
          result.getValueByParameter('t_$height$distanceUnitStr:C');
      _temperatureCubit.onData(temperature);

      final windSpeed =
          result.getValueByParameter('wind_speed_$height$distanceUnitStr:ms');
      _windCubit.onSpeedData(windSpeed);

      final windGusts =
          result.getValueByParameter('wind_gusts_$height$distanceUnitStr:ms');
      _windCubit.onGustsData(windGusts);

      final windDirection =
          result.getValueByParameter('wind_dir_$height$distanceUnitStr:d');
      _windCubit.onDirectionData(windDirection);

      final precipitation = result.getValueByParameter('precip_1h:mm');
      _precipitationCubit.onData(precipitation);

      final cloudiness = result.getValueByParameter('total_cloud_cover:p');
      _cloudinessCubit.onData(cloudiness);

      final visibility =
          result.getValueByParameter('visibility:$distanceUnitStr');
      _visibilityCubit.onData(visibility);

      final kpIndex = result.getValueByParameter('kp:idx');
      _kpIndexCubit.onData(kpIndex);

      emit(state.copyWith(
        isFetching: false,
      ));
    } catch (error) {
      emit(state.copyWith(
        isFetching: false,
        error: error.toString(),
      ));
    }
  }
}
