part of 'wind_cubit.dart';

@immutable
class WindState {
  const WindState({
    this.direction = 0,
    this.speedUnit = SpeedUnit.ms,
    double speed = 0,
    double gusts = 0,
    this.maxOn = true,
    this.gustsOn = true,
    double max = 30,
  })  : _speed = speed,
        _gusts = gusts,
        _max = max;

  WindState copyWith({
    double? direction,
    SpeedUnit? speedUnit,
    double? speed,
    double? gusts,
    bool? maxOn,
    bool? gustsOn,
    double? max,
  }) =>
      WindState(
        direction: direction ?? this.direction,
        speedUnit: speedUnit ?? this.speedUnit,
        speed: speed != null
            ? convertToSpeedUnit(speed, this.speedUnit, SpeedUnit.ms)
            : _speed,
        gusts: gusts != null
            ? convertToSpeedUnit(gusts, this.speedUnit, SpeedUnit.ms)
            : _gusts,
        maxOn: maxOn ?? this.maxOn,
        gustsOn: gustsOn ?? this.gustsOn,
        max: max != null
            ? convertToSpeedUnit(max, this.speedUnit, SpeedUnit.ms)
            : _max,
      );

  final double direction;
  final SpeedUnit speedUnit;
  final double _speed;
  double get speed {
    return convertToSpeedUnit(_speed, SpeedUnit.ms, speedUnit);
  }
  final double _gusts;
  double get gusts {
    return convertToSpeedUnit(_gusts, SpeedUnit.ms, speedUnit);
  }

  final bool gustsOn;
  final bool maxOn;
  final double _max;
  double get max {
    return convertToSpeedUnit(_max, SpeedUnit.ms, speedUnit).floorToDouble();
  }
}
