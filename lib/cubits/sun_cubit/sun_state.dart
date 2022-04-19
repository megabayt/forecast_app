part of 'sun_cubit.dart';

@immutable
class SunState extends WithDateState {
  SunState({
    DateTime? date,
    this.sunrises = const [],
    this.sunsets = const [],
  }) : super(date: (date ?? DateTime.now()));

  final List<Date> sunrises;
  final List<Date> sunsets;

  @override
  SunState copyWith({
    DateTime? date,
    List<Date>? sunrises,
    List<Date>? sunsets,
  }) =>
      SunState(
        date: date ?? this.date,
        sunrises: sunrises ?? this.sunrises,
        sunsets: sunsets ?? this.sunsets,
      );

  String get sunrise {
    final sunriseStr = sunrises
        .firstWhereOrNull(
            (element) => element.date.difference(date).inMinutes.abs() < 5)
        ?.value;
    if (sunriseStr == null) {
      return '';
    }
    final sunriseDate = DateTime.parse(sunriseStr);
    return '${sunriseDate.hour.toString().padLeft(2, '0')}:${sunriseDate.minute.toString().padLeft(2, '0')}';
  }

  String get sunset {
    final sunsetStr = sunsets
        .firstWhereOrNull(
            (element) => element.date.difference(date).inMinutes.abs() < 5)
        ?.value;
    if (sunsetStr == null) {
      return '';
    }
    final sunsetDate = DateTime.parse(sunsetStr);
    return '${sunsetDate.hour.toString().padLeft(2, '0')}:${sunsetDate.minute.toString().padLeft(2, '0')}';
  }
}
