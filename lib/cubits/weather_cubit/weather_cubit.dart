import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'weather_state.dart';
part 'weather_cubit.g.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherState());

  onData(Map<String, dynamic> data) {
    emit(state.copyWith(data: data));
  }
}
