import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:forecast_app/cubits/sun_cubit/sun_cubit.dart';
import 'package:forecast_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:forecast_app/interfaces/common_info.dart';
import 'package:forecast_app/services/interfaces/network_service.dart';
import 'package:forecast_app/services/service_locator.dart';
import 'package:meta/meta.dart';

part 'weather_bloc.g.dart';
part 'common_event.dart';
part 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  final NetworkService _networkService = locator<NetworkService>();
  final WeatherCubit _weatherCubit;
  final SunCubit _sunCubit;

  CommonBloc({
    required WeatherCubit weatherCubit,
    required SunCubit sunCubit,
  })   : _weatherCubit = weatherCubit,
        _sunCubit = sunCubit,
        super(const CommonState()) {
    on<FetchAll>(_onWeatherFetch);
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
      final result = await _networkService.getCommonInfo();

      _weatherCubit
          .onValue(result.getValueByParameter('weather_symbol_30min:idx'));

      _sunCubit.onValue(
        sunrise: result.getValueByParameter('sunrise:sql'),
        sunset: result.getValueByParameter('sunset:sql'),
      );

      emit(state.copyWith(
        isFetching: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isFetching: false,
        error: e.toString(),
      ));
    }
  }
}
