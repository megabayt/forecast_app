part of 'weather_bloc.dart';

@immutable
@CopyWith()
class WeatherState {
  final WeatherInfo? data;
  final bool isFetching;
  final String error;

  const WeatherState({
    this.data,
    this.isFetching = false,
    this.error = '',
  });
}
