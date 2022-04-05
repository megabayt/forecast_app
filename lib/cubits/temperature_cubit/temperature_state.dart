part of 'temperature_cubit.dart';

@immutable
class TemperatureState {
  const TemperatureState({
    this.temperatureUnit = TemperatureUnit.celsius,
    this.minOn = true,
    this.maxOn = true,
    double min = -30,
    double max = 30,
    double value = 0,
  })  : _value = value,
        _min = min,
        _max = max;

  TemperatureState copyWith({
    TemperatureUnit? temperatureUnit,
    bool? minOn,
    bool? maxOn,
    double? min,
    double? max,
    double? value,
  }) =>
      TemperatureState(
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
        value: value != null
            ? convertToTemperatureUnit(
                value, this.temperatureUnit, TemperatureUnit.celsius)
            : _value,
      );

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

  final double _value;
  double get value {
    return convertToTemperatureUnit(
            _value, TemperatureUnit.celsius, temperatureUnit)
        .floorToDouble();
  }
}
