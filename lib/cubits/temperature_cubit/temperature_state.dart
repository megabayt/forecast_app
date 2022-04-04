part of 'temperature_cubit.dart';

@immutable
class TemperatureState {
  const TemperatureState({
    this.temperatureUnit = TemperatureUnit.celsius,
    this.distanceUnit = DistanceUnit.meters,
    this.minOn = true,
    this.maxOn = true,
    double height = -30,
    double min = -30,
    double max = 30,
    double value = 0,
  })  : _value = value,
        _height = height,
        _min = min,
        _max = max;

  TemperatureState copyWith({
    TemperatureUnit? temperatureUnit,
    DistanceUnit? distanceUnit,
    bool? minOn,
    bool? maxOn,
    double? height,
    double? min,
    double? max,
    double? value,
  }) =>
      TemperatureState(
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        distanceUnit: distanceUnit ?? this.distanceUnit,
        minOn: minOn ?? this.minOn,
        maxOn: maxOn ?? this.maxOn,
        height: height != null
            ? convertToDistanceUnit(
                height, this.distanceUnit, DistanceUnit.meters)
            : _height,
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
  final DistanceUnit distanceUnit;
  final bool minOn;
  final bool maxOn;

  final double _height;
  double get height {
    return convertToDistanceUnit(_height, DistanceUnit.meters, distanceUnit)
        .floorToDouble();
  }

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
