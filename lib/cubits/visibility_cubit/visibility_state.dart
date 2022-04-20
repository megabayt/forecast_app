part of 'visibility_cubit.dart';

@immutable
class VisibilityState implements WithDistanceUnitState, WithDateState {
  VisibilityState({
    DateTime? date,
    this.distanceUnit = DistanceUnit.meters,
    this.data = const {},
    this.minOn = true,
    double min = 2000,
  })  : _min = min,
        date = date ?? DateTime.now();

  @override
  VisibilityState copyWith({
    Map<String, dynamic>? data,
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
  @override
  String get dateUtcString {
    return date
        .toUtc()
        .toIso8601String()
        .replaceAll(RegExp(':\\d{2}\\.\\d+'), ':00');
  }

  final Map<String, dynamic> data;
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
        data[dateUtcString] ?? 0,
        DistanceUnit.meters,
        distanceUnit == DistanceUnit.meters
            ? DistanceUnit.kilometers
            : DistanceUnit.miles);
  }

  double get valueInMetersOrMiles {
    return convertToDistanceUnit(
        data[dateUtcString] ?? 0, DistanceUnit.meters, distanceUnit);
  }

  bool get recommended {
    return minOn && valueInMetersOrMiles > min;
  }
}
