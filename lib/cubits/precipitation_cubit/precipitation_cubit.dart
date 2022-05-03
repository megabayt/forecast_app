import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'precipitation_state.dart';
part 'precipitation_cubit.g.dart';

class PrecipitationCubit extends HydratedCubit<PrecipitationState> {
  PrecipitationCubit() : super(const PrecipitationState());

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
