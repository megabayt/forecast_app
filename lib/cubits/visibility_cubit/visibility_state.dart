part of 'visibility_cubit.dart';

@immutable
class VisibilityState {
  const VisibilityState({
    this.distanceUnit = DistanceUnit.meters,
    this.minOn = true,
    double min = 2000,
    double value = 0,
  })  : _value = value,
        _min = min;

  VisibilityState copyWith({
    DistanceUnit? distanceUnit,
    bool? minOn,
    double? min,
    double? value,
  }) =>
      VisibilityState(
        distanceUnit: distanceUnit ?? this.distanceUnit,
        minOn: minOn ?? this.minOn,
        min: min != null
            ? convertToDistanceUnit(min, this.distanceUnit, DistanceUnit.meters)
            : _min,
        value: value != null
            ? convertToDistanceUnit(
                value, this.distanceUnit, DistanceUnit.meters)
            : _value,
      );

  final DistanceUnit distanceUnit;
  final bool minOn;

  final double _min;
  double get min {
    return convertToDistanceUnit(_min, DistanceUnit.meters, distanceUnit)
        .floorToDouble();
  }

  double get minInKmOrMiles {
    return convertToDistanceUnit(
        _min,
        DistanceUnit.meters,
        distanceUnit == DistanceUnit.meters
            ? DistanceUnit.kilometers
            : DistanceUnit.miles);
  }

  final double _value;
  double get value {
    return convertToDistanceUnit(_value, DistanceUnit.meters, distanceUnit);
  }

  double get valueInKmOrMiles {
    return convertToDistanceUnit(
        _value,
        DistanceUnit.meters,
        distanceUnit == DistanceUnit.meters
            ? DistanceUnit.kilometers
            : DistanceUnit.miles);
  }
  
  get recommended {
    return minOn && value > min;
  }
}
