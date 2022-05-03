part of 'cloudiness_cubit.dart';

@immutable
@CopyWith()
class CloudinessState {
  const CloudinessState({
    this.data = const {},
    this.maxOn = true,
    this.max = 40,
  });

  final Map<String, dynamic> data;
  final bool maxOn;
  final double max;
}
