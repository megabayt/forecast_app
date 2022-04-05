import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/cubits/sun_cubit/sun_cubit.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';
import 'package:forecast_app/cubits/weather_cubit/weather_cubit.dart';
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
  final CommonSettingsCubit _commonSettingsCubit;

  CommonBloc({
    required WeatherCubit weatherCubit,
    required SunCubit sunCubit,
    required TemperatureCubit temperatureCubit,
    required CommonSettingsCubit commonSettingsCubit,
  })  : _weatherCubit = weatherCubit,
        _sunCubit = sunCubit,
        _temperatureCubit = temperatureCubit,
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
      final result = await _networkService.getCommonInfo(
        weatherSymbol: true,
        sunrise: true,
        sunset: true,
        temperatureHeight: _commonSettingsCubit.state.height.floor(),
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

      final temperature = result.getValueByParameter(
          't_${_commonSettingsCubit.state.height.floor()}m:C');
      if (temperature != null) {
        _temperatureCubit.onValue(temperature);
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
