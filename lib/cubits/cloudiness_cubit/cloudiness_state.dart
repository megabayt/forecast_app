part of 'cloudiness_cubit.dart';

@immutable
class CloudinessState {
  const CloudinessState({
    this.maxOn = true,
    this.max = 40,
    this.value = 0,
  });

  CloudinessState copyWith({
    bool? maxOn,
    double? max,
    double? value,
  }) =>
      CloudinessState(
        maxOn: maxOn ?? this.maxOn,
        max: max ?? this.max,
        value: value ?? this.value,
      );

  final bool maxOn;
  final double max;
  final double value;

  get recommended {
    return maxOn && value < max;
  }
}
