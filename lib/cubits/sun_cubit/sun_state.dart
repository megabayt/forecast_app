part of 'sun_cubit.dart';

@immutable
@CopyWith()
class SunState {
  const SunState({
    this.sunrises = const {},
    this.sunsets = const {},
  });

  final Map<String, dynamic> sunrises;
  final Map<String, dynamic> sunsets;
}
