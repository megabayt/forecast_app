part of 'weather_cubit.dart';

class WeatherState extends WithDateState {
  WeatherState({
    DateTime? date,
    this.data = const {},
  }) : super(date: date);

  final Map<String, dynamic> data;

  @override
  WeatherState copyWith({
    DateTime? date,
    Map<String, dynamic>? data,
  }) =>
      WeatherState(
        date: date ?? this.date,
        data: data ?? this.data,
      );

  int get value {
    return data[roundToNearest5String(date)] ?? 0;
  }
}
