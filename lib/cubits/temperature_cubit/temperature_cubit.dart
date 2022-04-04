import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:meta/meta.dart';

part 'temperature_state.dart';
part 'temperature_cubit.g.dart';

class TemperatureCubit extends Cubit<TemperatureState> {
  TemperatureCubit() : super(const TemperatureState());

  onValue(double? newValue) {
    emit(state.copyWith(
      value: newValue,
    ));
  }

  onChangeUnit(Unit newUnit) {
    emit(state.copyWith(
      unit: newUnit,
    ));
  }

  onChangeHeight(int? newHeight) {
    emit(state.copyWith(
      height: newHeight,
    ));
  }

  onChangeMin(int? newMin) {
    emit(state.copyWith(
      min: newMin,
    ));
  }

  onChangeMax(int? newMax) {
    emit(state.copyWith(
      max: newMax,
    ));
  }
}
