part of 'visibility_cubit.dart';

@immutable
@CopyWith()
class VisibilityState {
  const VisibilityState({
    this.data = const {},
    this.minOn = true,
    this.min = 2000,
  });


  final Map<String, dynamic> data;
  final bool minOn;
  final double min;
}
