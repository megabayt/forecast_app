part of 'weather_cubit.dart';

class WeatherState extends WithDateState {
  WeatherState({
    DateTime? date,
    this.data = const [],
  }) : super(date: (date ?? DateTime.now()));

  final List<Date> data;

  @override
  WeatherState copyWith({
    DateTime? date,
    List<Date>? data,
  }) =>
      WeatherState(
        date: date ?? this.date,
        data: data ?? this.data,
      );

  int get value {
    return data
        .firstWhereOrNull(
            (element) => element.date.difference(date).inMinutes.abs() < 5)
        ?.value ?? 0;
  }
}
