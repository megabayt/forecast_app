import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'location_state.dart';
part 'location_cubit.g.dart';

class LocationCubit extends HydratedCubit<LocationState> {
  LocationCubit() : super(LocationState());

  void onLoading() {
    emit(state.copyWith(loading: true));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(state.copyWith(loading: false, error: true));
    super.onError(error, stackTrace);
  }

  void onValue(Position newValue) {
    emit(state.copyWith(position: newValue, loading: false));
  }

  @override
  LocationState fromJson(Map<String, dynamic> json) => LocationState(
        position: json['position'] != null
            ? Position.fromMap(json['position'])
            : null,
      );

  @override
  Map<String, dynamic> toJson(LocationState state) => {
        'position': state.position?.toJson(),
      };
}
