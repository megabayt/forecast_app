part of 'common_settings_cubit.dart';

@immutable
@CopyWith()
class CommonSettingsState {
  const CommonSettingsState({
    this.distanceUnit = DistanceUnit.meters,
    this.height = 2,
  });

  final DistanceUnit distanceUnit;
  final double height;
}
