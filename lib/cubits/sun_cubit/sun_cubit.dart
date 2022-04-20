import 'package:bloc/bloc.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';
import 'package:forecast_app/mixins/with_date.dart';
import 'package:meta/meta.dart';

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
    required Map<String, dynamic> sunrise,
    required Map<String, dynamic> sunset,
  }) {
    emit(SunState(sunrises: sunrise, sunsets: sunset));
  }
}
