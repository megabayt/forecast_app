part of 'temperature_cubit.dart';

@immutable
class TemperatureState {
  const TemperatureState({double value = 0}) : _value = value;

  TemperatureState copyWith({
    double? value,
  }) =>
      TemperatureState(
        value: value != null
            ? convertToTemperatureUnit(
                value, this.temperatureUnit, TemperatureUnit.celsius)
            : _value,
      );

  final double _value;
  double get value {
    return convertToTemperatureUnit(
            _value, TemperatureUnit.celsius, temperatureUnit)
        .floorToDouble();
  }
}
