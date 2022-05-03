import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'kpindex_state.dart';
part 'kpindex_cubit.g.dart';

class KpIndexCubit extends HydratedCubit<KpIndexState> {
  KpIndexCubit() : super(const KpIndexState());

  onData(Map<String, dynamic> data) {
    emit(state.copyWith(
      data: data,
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
      );

  @override
  Map<String, dynamic> toJson(KpIndexState state) => {
        'maxOn': state.maxOn,
        'max': state.max,
      };
}
