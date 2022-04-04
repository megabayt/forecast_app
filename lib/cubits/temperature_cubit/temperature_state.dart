part of 'temperature_cubit.dart';

@immutable
class TemperatureState {
  const TemperatureState({
    this.unit = TemperatureUnit.celsius,
    this.minOn = true,
    this.maxOn = true,
    double min = -30,
    double max = 30,
    double value = 0,
  })  : _value = value,
        _min = min,
        _max = max;

  TemperatureState copyWith({
    TemperatureUnit? unit,
    bool? minOn,
    bool? maxOn,
    double? min,
    double? max,
    double? value,
  }) =>
      TemperatureState(
        unit: unit ?? this.unit,
        minOn: minOn ?? this.minOn,
        maxOn: maxOn ?? this.maxOn,
        min: min != null
            ? convertToUnit(min, this.unit, TemperatureUnit.celsius)
            : _min,
        max: max != null
            ? convertToUnit(max, this.unit, TemperatureUnit.celsius)
            : _max,
        value: value != null
            ? convertToUnit(value, this.unit, TemperatureUnit.celsius)
            : _value,
      );

  final TemperatureUnit unit;
  final bool minOn;
  final bool maxOn;

  final double _min;
  double get min {
    return convertToUnit(_min, TemperatureUnit.celsius, unit).floorToDouble();
  }

  final double _max;
  double get max {
    return convertToUnit(_max, TemperatureUnit.celsius, unit).floorToDouble();
  }

  final double _value;
  double get value {
    return convertToUnit(_value, TemperatureUnit.celsius, unit).floorToDouble();
  }
}
