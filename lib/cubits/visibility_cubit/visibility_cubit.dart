import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'visibility_state.dart';
part 'visibility_cubit.g.dart';

class VisibilityCubit extends HydratedCubit<VisibilityState> {
  VisibilityCubit() : super(const VisibilityState());

  onData(Map<String, dynamic> data) {
    emit(state.copyWith(
      data: data,
    ));
  }

  onChangeMin(double newMin) {
    emit(state.copyWith(
      min: newMin,
    ));
  }

  onToggleMin() {
    emit(state.copyWith(
      minOn: !state.minOn,
    ));
  }

  @override
  VisibilityState fromJson(Map<String, dynamic> json) => VisibilityState(
        minOn: json['minOn'],
        min: json['min'],
      );

  @override
  Map<String, dynamic> toJson(VisibilityState state) => {
        'minOn': state.minOn,
        'min': state.min,
      };
}
