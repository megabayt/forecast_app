import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'kpindex_state.dart';

class KpIndexCubit extends HydratedCubit<KpIndexState> {
  KpIndexCubit() : super(const KpIndexState());

  onValue(int newValue) {
    emit(state.copyWith(
      value: newValue,
    ));
  }

  onChangeMax(int newMax) {
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
  KpIndexState fromJson(Map<String, dynamic> json) => KpIndexState(
        maxOn: json['maxOn'],
        max: json['max'],
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson(KpIndexState state) => {
        'maxOn': state.maxOn,
        'max': state.max,
        'value': state.value,
      };
}
