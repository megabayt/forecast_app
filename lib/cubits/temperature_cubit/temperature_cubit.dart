import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:meta/meta.dart';

part 'temperature_state.dart';
part 'temperature_cubit.g.dart';

class TemperatureCubit extends HydratedCubit<TemperatureState> {
  TemperatureCubit() : super(const TemperatureState());

  onData(Map<String, dynamic> data) {
    emit(state.copyWith(
      data: data,
    ));
  }

  onChangeTemperatureUnit(TemperatureUnit newUnit) {
    emit(state.copyWith(
      temperatureUnit: newUnit,
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
        temperatureUnit:
            TemperatureUnit.values.elementAt(json['temperatureUnit']),
        minOn: json['minOn'],
        maxOn: json['maxOn'],
        min: json['min'],
        max: json['max'],
      );

  @override
  Map<String, dynamic> toJson(TemperatureState state) => {
        'temperatureUnit': state.temperatureUnit.index,
        'minOn': state.minOn,
        'maxOn': state.maxOn,
        'min': state.min,
        'max': state.max,
      };
}
