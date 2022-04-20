part of 'sun_cubit.dart';

@immutable
class SunState extends WithDateState {
  SunState({
    DateTime? date,
    this.sunrises = const {},
    this.sunsets = const {},
  }) : super(date: (date ?? DateTime.now()));

  final Map<String, dynamic> sunrises;
  final Map<String, dynamic> sunsets;

  @override
  SunState copyWith({
    DateTime? date,
    Map<String, dynamic>? sunrises,
    Map<String, dynamic>? sunsets,
  }) =>
      SunState(
        date: date ?? this.date,
        sunrises: sunrises ?? this.sunrises,
        sunsets: sunsets ?? this.sunsets,
      );

  String get sunrise {
    final sunriseStr = sunrises[roundToNearest5String(date)];
    if (sunriseStr == null) {
      return '';
    }
    final sunriseDate = DateTime.parse(sunriseStr);
    return '${sunriseDate.hour.toString().padLeft(2, '0')}:${sunriseDate.minute.toString().padLeft(2, '0')}';
  }

  String get sunset {
    final sunsetStr = sunsets[roundToNearest5String(date)];
    if (sunsetStr == null) {
      return '';
    }
    final sunsetDate = DateTime.parse(sunsetStr);
    return '${sunsetDate.hour.toString().padLeft(2, '0')}:${sunsetDate.minute.toString().padLeft(2, '0')}';
  }
}
