import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/interfaces/position_with_placemark.dart';
import 'package:forecast_app/services/interfaces/geolocation_service.dart';
import 'package:forecast_app/services/service_locator.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:meta/meta.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

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
        isFetching: true,
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
    _commonBloc.add(FetchAll(position: event.data.position));
    emit(state.copyWith(
      isFetching: false,
      myLocation: event.data,
    ));
  }

  void _onMyLocationFetchError(
    FetchMyLocationError event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(
      isFetching: false,
      error: event.error.toString(),
    ));
  }

  void _onLocationFetch(
    FetchLocation event,
    Emitter<LocationState> emit,
  ) async {}
  void _onLocationFetchSuccess(
    FetchLocationSuccess event,
    Emitter<LocationState> emit,
  ) async {}
  void _onLocationFetchError(
    FetchLocationError event,
    Emitter<LocationState> emit,
  ) async {}
}
