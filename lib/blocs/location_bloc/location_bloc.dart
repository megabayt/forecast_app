import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/interfaces/position_with_placemark.dart';
import 'package:forecast_app/services/interfaces/geolocation_service.dart';
import 'package:forecast_app/services/service_locator.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:meta/meta.dart';

part 'location_bloc.g.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GeolocationService _geolocationService = locator<GeolocationService>();
  final CommonBloc _commonBloc;

  LocationBloc({required CommonBloc commonBloc})
      : _commonBloc = commonBloc,
        super(const LocationState()) {
    on<FetchMyLocation>(
      _onMyLocationFetch,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<FetchMyLocationSuccess>(_onMyLocationFetchSuccess);
    on<FetchMyLocationError>(_onMyLocationFetchError);
    on<FetchLocation>(
      _onLocationFetch,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<FetchLocationSuccess>(_onLocationFetchSuccess);
    on<FetchLocationError>(_onLocationFetchError);
  }

  void _onMyLocationFetch(
    FetchMyLocation event,
    Emitter<LocationState> emit,
  ) async {
    try {
      emit(state.copyWith(
        isFetchingMyLocation: true,
      ));
      final location = await _geolocationService.getCurrentLocation();
      add(FetchMyLocationSuccess(data: location));
    } catch (error) {
      add(FetchMyLocationError(error: error.toString()));
    }
  }

  void _onMyLocationFetchSuccess(
    FetchMyLocationSuccess event,
    Emitter<LocationState> emit,
  ) async {
    _commonBloc.add(FetchAll(point: event.data.point));
    emit(state.copyWith(
      isFetchingMyLocation: false,
      myLocation: event.data,
    ));
  }

  void _onMyLocationFetchError(
    FetchMyLocationError event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(
      isFetchingMyLocation: false,
      errorMyLocation: event.error.toString(),
    ));
  }

  void _onLocationFetch(
    FetchLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(
      isFetchingSearch: true,
    ));
    try {
      final result =
          await _geolocationService.getLocationsByAddress(event.address);
      add(FetchLocationSuccess(data: result));
    } catch (error) {
      add(FetchLocationError(error: error.toString()));
    }
  }

  void _onLocationFetchSuccess(
    FetchLocationSuccess event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(
      isFetchingSearch: false,
      foundPositions: event.data,
    ));
  }

  void _onLocationFetchError(
    FetchLocationError event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(
      isFetchingSearch: false,
      errorSearch: event.error,
    ));
  }
}
