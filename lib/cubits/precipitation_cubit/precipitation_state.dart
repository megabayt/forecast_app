part of 'precipitation_cubit.dart';

@immutable
@CopyWith()
class PrecipitationState {
  const PrecipitationState({
    this.data = const {},
    this.maxOn = true,
    this.max = 40,
  });

  final Map<String, dynamic> data;
  final bool maxOn;
  final double max;
}
