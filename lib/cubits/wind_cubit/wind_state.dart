part of 'wind_cubit.dart';

@immutable
@CopyWith()
class WindState {
  const WindState({
    this.speedData = const {},
    this.gustsData = const {},
    this.directionData = const {},
    this.speedUnit = SpeedUnit.ms,
    this.maxOn = true,
    this.gustsOn = true,
    this.max = 30,
  });

  final Map<String, dynamic> speedData;
  final Map<String, dynamic> gustsData;
  final Map<String, dynamic> directionData;
  final SpeedUnit speedUnit;
  final bool gustsOn;
  final bool maxOn;
  final double max;
}
