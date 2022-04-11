part of 'location_cubit.dart';

@CopyWith()
class LocationState {
  LocationState({
    this.data,
    this.loading = false,
    this.error = false,
  });

  PositionWithPlaceMark? data;
  bool loading;
  bool error;
}
