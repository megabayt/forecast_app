import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'temperature_state.dart';

class TemperatureCubit extends HydratedCubit<TemperatureState> {
  TemperatureCubit() : super(const TemperatureState());

  onValue(double newValue) {
    emit(state.copyWith(
      value: convertToUnit(newValue, TemperatureUnit.celsius, state.unit),
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

  @override
  TemperatureState fromJson(Map<String, dynamic> json) => TemperatureState(
        unit: TemperatureUnit.values.elementAt(json['unit']),
        minOn: json['minOn'],
        maxOn: json['maxOn'],
        min: json['min'],
        max: json['max'],
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson(TemperatureState state) => {
        'unit': state.unit.index,
        'minOn': state.minOn,
        'maxOn': state.maxOn,
        'min': state._min,
        'max': state._max,
        'value': state._value,
      };
}
