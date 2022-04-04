import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'temperature_state.dart';

class TemperatureCubit extends HydratedCubit<TemperatureState> {
  TemperatureCubit() : super(const TemperatureState());

  onValue(double newValue) {
    emit(state.copyWith(
      value: convertToTemperatureUnit(
          newValue, TemperatureUnit.celsius, state.temperatureUnit),
    ));
  }

  onChangeTemperatureUnit(TemperatureUnit newUnit) {
    emit(state.copyWith(
      temperatureUnit: newUnit,
    ));
  }

  onChangeDistanceUnit(DistanceUnit newUnit) {
    emit(state.copyWith(
      distanceUnit: newUnit,
    ));
  }

  onChangeMin(double newMin) {
    emit(state.copyWith(
      min: newMin >= state.max ? state.max : newMin,
    ));
  }

  onChangeHeight(double newHeight) {
    emit(state.copyWith(
      height: newHeight,
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
        temperatureUnit:
            TemperatureUnit.values.elementAt(json['temperatureUnit']),
        distanceUnit: DistanceUnit.values.elementAt(json['distanceUnit']),
        minOn: json['minOn'],
        maxOn: json['maxOn'],
        min: json['min'],
        height: json['height'],
        max: json['max'],
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson(TemperatureState state) => {
        'temperatureUnit': state.temperatureUnit.index,
        'distanceUnit': state.distanceUnit.index,
        'minOn': state.minOn,
        'maxOn': state.maxOn,
        'min': state._min,
        'height': state._height,
        'max': state._max,
        'value': state._value,
      };
}
