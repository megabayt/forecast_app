part of 'common_settings_cubit.dart';

@immutable
class CommonSettingsState {
  const CommonSettingsState({
    this.distanceUnit = DistanceUnit.meters,
    double height = 2,
  }) : _height = height;

  CommonSettingsState copyWith({
    DistanceUnit? distanceUnit,
    double? height,
  }) =>
      CommonSettingsState(
        distanceUnit: distanceUnit ?? this.distanceUnit,
        height: height != null
            ? convertToDistanceUnit(
                height, this.distanceUnit, DistanceUnit.meters)
            : _height,
      );

  final DistanceUnit distanceUnit;
  final double _height;
  double get height {
    return convertToDistanceUnit(_height, DistanceUnit.meters, distanceUnit)
        .floorToDouble();
  }
}
