part of 'visibility_cubit.dart';

@immutable
class VisibilityState implements WithDistanceUnitState, WithDateState {
  VisibilityState({
    DateTime? date,
    this.distanceUnit = DistanceUnit.meters,
    this.data = const [],
    this.minOn = true,
    double min = 2000,
  })  : _min = min,
        date = date ?? DateTime.now();

  @override
  VisibilityState copyWith({
    List<Date>? data,
    DistanceUnit? distanceUnit,
    DateTime? date,
    bool? minOn,
    double? min,
  }) =>
      VisibilityState(
        data: data ?? this.data,
        distanceUnit: distanceUnit ?? this.distanceUnit,
        date: date ?? this.date,
        minOn: minOn ?? this.minOn,
        min: min != null
            ? convertToDistanceUnit(min, this.distanceUnit, DistanceUnit.meters)
            : _min,
      );

  @override
  final DistanceUnit distanceUnit;
  @override
  final DateTime date;
  final List<Date> data;
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

  double get value {
    return convertToDistanceUnit(
        data
                .firstWhereOrNull((element) =>
                    element.date.difference(date).inMinutes.abs() < 5)
                ?.value ??
            0,
        DistanceUnit.meters,
        distanceUnit == DistanceUnit.meters
            ? DistanceUnit.kilometers
            : DistanceUnit.miles);
  }

  double get valueInMetersOrMiles {
    return convertToDistanceUnit(
        data
                .firstWhereOrNull((element) =>
                    element.date.difference(date).inMinutes.abs() < 5)
                ?.value ??
            0,
        DistanceUnit.meters,
        distanceUnit);
  }

  get recommended {
    return minOn && valueInMetersOrMiles > min;
  }
}
