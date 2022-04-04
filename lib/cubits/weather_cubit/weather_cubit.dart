import 'package:bloc/bloc.dart';

class WeatherCubit extends Cubit<int> {
  WeatherCubit() : super(0);

  onValue(int newValue) {
    emit(newValue);
  }
}
