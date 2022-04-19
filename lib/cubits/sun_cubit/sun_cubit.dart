import 'package:bloc/bloc.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';
import 'package:forecast_app/interfaces/common_info.dart';
import 'package:forecast_app/mixins/with_date.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

part 'sun_state.dart';

class SunCubit extends Cubit<SunState> with WithDate {
  SunCubit({required DateCubit dateCubit}) : super(SunState()) {
    subDate(dateCubit);
  }

  @override
  close() async {
    await unsubDate();
    super.close();
  }

  onData({
    required List<Date> sunrise,
    required List<Date> sunset,
  }) {
    emit(SunState(sunrises: sunrise, sunsets: sunset));
  }
}
