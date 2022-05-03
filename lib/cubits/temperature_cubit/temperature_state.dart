part of 'temperature_cubit.dart';

@immutable
@CopyWith()
class TemperatureState {
  const TemperatureState({
    this.data = const {},
    this.temperatureUnit = TemperatureUnit.celsius,
    this.minOn = true,
    this.maxOn = true,
    this.min = -30,
    this.max = 30,
  });

  final Map<String, dynamic> data;
  final TemperatureUnit temperatureUnit;
  final bool minOn;
  final bool maxOn;
  final double min;
  final double max;
}
