part of 'temperature_cubit.dart';

@immutable
@CopyWith()
class TemperatureState {
  const TemperatureState({
    this.height,
    this.min,
    this.max,
    this.unit = Unit.celsius,
    double? value,
  }) : _value = value;

  final int? height;
  final int? min;
  final int? max;
  final Unit unit;
  final double? _value;
  double? get value {
    if (_value == null) {
      return null;
    }
    if (unit == Unit.celsius) {
      return _value;
    }
    return (_value !* 9 / 5) + 32;
  }
}

enum Unit {
  celsius,
  farenheight,
}
