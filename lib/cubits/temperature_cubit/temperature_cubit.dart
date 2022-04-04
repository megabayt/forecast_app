import 'package:bloc/bloc.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:meta/meta.dart';

part 'temperature_state.dart';

class TemperatureCubit extends Cubit<TemperatureState> {
  TemperatureCubit() : super(const TemperatureState());

  onValue(double newValue) {
    emit(state.copyWith(
      value: newValue,
    ));
  }

  onChangeUnit(TemperatureUnit newUnit) {
    emit(state.copyWith(
      unit: newUnit,
    ));
  }

  onChangeMin(double newMin) {
    emit(state.copyWith(
      min: newMin >= state.max ? state.max : newMin,
    ));
  }

  onToggleMin() {
    emit(state.copyWith(
      minOn: !state.minOn,
    ));
  }

  onChangeMax(double newMax) {
    emit(state.copyWith(
      max: newMax <= state.min ? state.min : newMax,
    ));
  }

  onToggleMax() {
    emit(state.copyWith(
      maxOn: !state.maxOn,
    ));
  }
}
