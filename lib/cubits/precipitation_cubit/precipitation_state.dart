part of 'precipitation_cubit.dart';

@immutable
class PrecipitationState {
  const PrecipitationState({
    this.maxOn = true,
    this.max = 40,
    this.value = 0,
  });

  PrecipitationState copyWith({
    bool? maxOn,
    double? max,
    double? value,
  }) =>
      PrecipitationState(
        maxOn: maxOn ?? this.maxOn,
        max: max ?? this.max,
        value: value ?? this.value,
      );

  final bool maxOn;
  final double max;
  final double value;
}
