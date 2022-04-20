import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';
import 'package:forecast_app/mixins/with_date.dart';
import 'package:meta/meta.dart';

part 'precipitation_state.dart';

class PrecipitationCubit extends HydratedCubit<PrecipitationState>
    with WithDate {
  PrecipitationCubit({required DateCubit dateCubit})
      : super(PrecipitationState()) {
    subDate(dateCubit);
  }

  @override
  close() async {
    await unsubDate();
    super.close();
  }

  onData(Map<String, dynamic> data) {
    emit(state.copyWith(
      data: data,
    ));
  }

  onChangeMax(double newMax) {
    emit(state.copyWith(
      max: newMax,
    ));
  }

  onToggleMax() {
    emit(state.copyWith(
      maxOn: !state.maxOn,
    ));
  }

  @override
  PrecipitationState fromJson(Map<String, dynamic> json) => PrecipitationState(
        maxOn: json['maxOn'],
        max: json['max'],
      );

  @override
  Map<String, dynamic> toJson(PrecipitationState state) => {
        'maxOn': state.maxOn,
        'max': state.max,
      };
}
