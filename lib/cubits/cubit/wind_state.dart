part of 'wind_cubit.dart';

@immutable
class WindState {
  const WindState({
    this.speedUnit = SpeedUnit.ms,
    double value = 0,
  }) : _value = value;

  WindState copyWith({
    SpeedUnit? speedUnit,
    double? value,
  }) =>
      WindState(
        speedUnit: speedUnit ?? this.speedUnit,
        value: value != null
            ? convertToSpeedUnit(value, this.speedUnit, SpeedUnit.ms)
            : _value,
      );

  final SpeedUnit speedUnit;
  final double _value;
  double get value {
    return convertToSpeedUnit(_value, SpeedUnit.ms, speedUnit);
  }
}
