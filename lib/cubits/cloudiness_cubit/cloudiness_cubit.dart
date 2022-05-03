import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'cloudiness_state.dart';
part 'cloudiness_cubit.g.dart';

class CloudinessCubit extends HydratedCubit<CloudinessState> {
  CloudinessCubit() : super(const CloudinessState());

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
