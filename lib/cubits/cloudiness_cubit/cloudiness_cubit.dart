import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'cloudiness_state.dart';

class CloudinessCubit extends HydratedCubit<CloudinessState> {
  CloudinessCubit() : super(const CloudinessState());

  onValue(double newValue) {
    emit(state.copyWith(
      value: newValue,
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
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson(CloudinessState state) => {
        'maxOn': state.maxOn,
        'max': state.max,
        'value': state.value,
      };
}
