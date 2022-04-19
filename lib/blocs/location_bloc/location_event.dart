part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class FetchMyLocation extends LocationEvent {}

class FetchMyLocationSuccess extends LocationEvent {
  FetchMyLocationSuccess({required this.data});

  final PositionWithAddress data;
}

class FetchMyLocationError extends LocationEvent {
  FetchMyLocationError({required this.error});

  final String error;
}

class FetchLocation extends LocationEvent {
  FetchLocation({required this.address});

  final String address;
}

class FetchLocationSuccess extends LocationEvent {
  FetchLocationSuccess({required this.data});

  final List<PositionWithAddress> data;
}

class FetchLocationError extends LocationEvent {
  FetchLocationError({required this.error});

  final String error;
}
