import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:forecast_app/interfaces/weather_info.dart';
import 'package:forecast_app/services/interfaces/weather_service.dart';
import 'package:forecast_app/services/service_locator.dart';
import 'package:meta/meta.dart';

part 'weather_bloc.g.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService _weatherService = locator<WeatherService>();

  WeatherBloc() : super(const WeatherState()) {
    on<WeatherFetch>(_onWeatherFetch);
  }

  void _onWeatherFetch(
    WeatherFetch event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(
      isFetching: true,
      error: '',
    ));

    try {
      final result = await _weatherService.getWeatherInfo();

      emit(state.copyWith(
        data: result,
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
