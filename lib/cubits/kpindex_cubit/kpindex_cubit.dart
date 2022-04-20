import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';
import 'package:forecast_app/mixins/with_date.dart';
import 'package:meta/meta.dart';

part 'kpindex_state.dart';

class KpIndexCubit extends HydratedCubit<KpIndexState> with WithDate {
  KpIndexCubit({required DateCubit dateCubit}) : super(KpIndexState()) {
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
