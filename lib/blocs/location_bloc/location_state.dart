part of 'location_bloc.dart';

@immutable
@CopyWith()
class LocationState {
  final bool isFetchingMyLocation;
  final String errorMyLocation;
  final PositionWithAddress? myLocation;
  final bool isFetchingSearch;
  final String errorSearch;
  final List<PositionWithAddress>? foundPositions;

  const LocationState({
    this.isFetchingMyLocation = false,
    this.errorMyLocation = '',
    this.myLocation,
    this.isFetchingSearch = false,
    this.errorSearch = '',
    this.foundPositions,
  });
}
