import 'package:flutter/cupertino.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  onChangeHeight(double newHeight) {
    emit(state.copyWith(
      height: newHeight,
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

  @override
  SettingsState fromJson(Map<String, dynamic> json) => SettingsState(
        temperatureUnit:
            TemperatureUnit.values.elementAt(json['temperatureUnit']),
        distanceUnit: DistanceUnit.values.elementAt(json['distanceUnit']),
        minOn: json['minOn'],
        maxOn: json['maxOn'],
        min: json['min'],
        height: json['height'],
        max: json['max'],
      );

  @override
  Map<String, dynamic> toJson(SettingsState state) => {
        'temperatureUnit': state.temperatureUnit.index,
        'distanceUnit': state.distanceUnit.index,
        'minOn': state.minOn,
        'maxOn': state.maxOn,
        'min': state._min,
        'height': state._height,
        'max': state._max,
      };
}
