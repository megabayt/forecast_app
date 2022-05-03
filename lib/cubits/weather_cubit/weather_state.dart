part of 'weather_cubit.dart';

@CopyWith()
class WeatherState {
  WeatherState({
    this.data = const {},
  });

  final Map<String, dynamic> data;
}
