import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';
import 'package:forecast_app/mixins/with_date.dart';
import 'package:meta/meta.dart';

part 'cloudiness_state.dart';

class CloudinessCubit extends HydratedCubit<CloudinessState> with WithDate {
  CloudinessCubit({required DateCubit dateCubit}) : super(CloudinessState()) {
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
  CloudinessState fromJson(Map<String, dynamic> json) => CloudinessState(
        maxOn: json['maxOn'],
        max: json['max'],
      );

  @override
  Map<String, dynamic> toJson(CloudinessState state) => {
        'maxOn': state.maxOn,
        'max': state.max,
      };
}
