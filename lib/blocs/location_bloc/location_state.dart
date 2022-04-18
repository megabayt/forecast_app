part of 'location_bloc.dart';

@immutable
@CopyWith()
class LocationState {
  final bool isFetching;
  final String error;
  final PositionWithAddress? myLocation;
  final GeocodeResponse? foundPosition;

  const LocationState({
    this.isFetching = false,
    this.error = '',
    this.myLocation,
    this.foundPosition,
  });
}
