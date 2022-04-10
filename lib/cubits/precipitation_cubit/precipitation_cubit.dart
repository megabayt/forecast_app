import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'precipitation_state.dart';

class PrecipitationCubit extends HydratedCubit<PrecipitationState> {
  PrecipitationCubit() : super(const PrecipitationState());

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
  PrecipitationState fromJson(Map<String, dynamic> json) => PrecipitationState(
        maxOn: json['maxOn'],
        max: json['max'],
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson(PrecipitationState state) => {
        'maxOn': state.maxOn,
        'max': state.max,
        'value': state.value,
      };
}
