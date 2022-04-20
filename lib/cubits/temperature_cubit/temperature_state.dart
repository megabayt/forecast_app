part of 'temperature_cubit.dart';

@immutable
class TemperatureState extends WithDateState {
  TemperatureState({
    DateTime? date,
    this.data = const {},
    this.temperatureUnit = TemperatureUnit.celsius,
    this.minOn = true,
    this.maxOn = true,
    double min = -30,
    double max = 30,
  })  : _min = min,
        _max = max,
        super(date: (date ?? DateTime.now()));

  @override
  TemperatureState copyWith({
    DateTime? date,
    TemperatureUnit? temperatureUnit,
    Map<String, dynamic>? data,
    bool? minOn,
    bool? maxOn,
    double? min,
    double? max,
  }) =>
      TemperatureState(
        date: date ?? this.date,
        data: data ?? this.data,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        minOn: minOn ?? this.minOn,
        maxOn: maxOn ?? this.maxOn,
        min: min != null
            ? convertToTemperatureUnit(
                min, this.temperatureUnit, TemperatureUnit.celsius)
            : _min,
        max: max != null
            ? convertToTemperatureUnit(
                max, this.temperatureUnit, TemperatureUnit.celsius)
            : _max,
      );

  final Map<String, dynamic> data;
  final TemperatureUnit temperatureUnit;
  final bool minOn;
  final bool maxOn;

  final double _min;
  double get min {
    return convertToTemperatureUnit(
            _min, TemperatureUnit.celsius, temperatureUnit)
        .floorToDouble();
  }

  final double _max;
  double get max {
    return convertToTemperatureUnit(
            _max, TemperatureUnit.celsius, temperatureUnit)
        .floorToDouble();
  }

  double get value {
    return getValueByDate(date);
  }

  double getValueByDate(DateTime date) {
    return convertToTemperatureUnit(data[roundToNearest5String(date)] ?? 0,
        TemperatureUnit.celsius, temperatureUnit);
  }

  bool get recommended {
    return getRecommendedByDate(date);
  }

  bool getRecommendedByDate(DateTime date) {
    if (maxOn && getValueByDate(date) >= max) {
      return false;
    }
    if (minOn && getValueByDate(date) <= min) {
      return false;
    }
    return true;
  }
}
