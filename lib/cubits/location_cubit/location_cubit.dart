import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:forecast_app/interfaces/position_with_placemark.dart';
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

  void onData(PositionWithAddress newValue) {
    emit(state.copyWith(data: newValue, loading: false));
  }

  @override
  LocationState fromJson(Map<String, dynamic> json) => LocationState(
        data: json['data'] != null
            ? PositionWithAddress.fromJson(json['data'])
            : null,
      );

  @override
  Map<String, dynamic> toJson(LocationState state) => {
        'data': state.data?.toJson(),
      };
}
