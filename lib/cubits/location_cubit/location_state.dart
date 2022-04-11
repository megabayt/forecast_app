part of 'location_cubit.dart';

@CopyWith()
class LocationState {
  LocationState({
    this.position,
    this.loading = false,
    this.error = false,
  });

  Position? position;
  bool loading;
  bool error;
}
