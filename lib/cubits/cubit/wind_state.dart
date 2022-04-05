part of 'wind_cubit.dart';

@immutable
class WindState {
  const WindState({
    this.speedUnit = SpeedUnit.ms,
    double speed = 0,
    this.maxOn = true,
    this.gustsOn = true,
    double max = 30,
  })  : _speed = speed,
        _max = max;

  WindState copyWith({
    SpeedUnit? speedUnit,
    double? speed,
    bool? maxOn,
    bool? gustsOn,
    double? max,
  }) =>
      WindState(
        speedUnit: speedUnit ?? this.speedUnit,
        speed: speed != null
            ? convertToSpeedUnit(speed, this.speedUnit, SpeedUnit.ms)
            : _speed,
        maxOn: maxOn ?? this.maxOn,
        gustsOn: gustsOn ?? this.gustsOn,
        max: max != null
            ? convertToSpeedUnit(max, this.speedUnit, SpeedUnit.ms)
            : _max,
      );

  final SpeedUnit speedUnit;
  final double _speed;
  double get speed {
    return convertToSpeedUnit(_speed, SpeedUnit.ms, speedUnit);
  }

  final bool gustsOn;
  final bool maxOn;
  final double _max;
  double get max {
    return convertToSpeedUnit(_max, SpeedUnit.ms, speedUnit).floorToDouble();
  }
}
