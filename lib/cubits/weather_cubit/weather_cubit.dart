import 'package:bloc/bloc.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';
import 'package:forecast_app/mixins/with_date.dart';
import 'package:forecast_app/utils/helpers.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> with WithDate {
  WeatherCubit({required DateCubit dateCubit}) : super(WeatherState()) {
    subDate(dateCubit);
  }

  @override
  close() async {
    await unsubDate();
    super.close();
  }

  onData(Map<String, dynamic> data) {
    emit(state.copyWith(data: data));
  }
}
