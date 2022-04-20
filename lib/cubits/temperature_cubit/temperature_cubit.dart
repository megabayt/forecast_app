import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/mixins/with_date.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:meta/meta.dart';

part 'temperature_state.dart';

class TemperatureCubit extends HydratedCubit<TemperatureState> with WithDate {
  TemperatureCubit({required DateCubit dateCubit}) : super(TemperatureState()) {
    subDate(dateCubit);
  }

  @override
  close() async {
    await unsubDate();
    super.close();
  }

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
        'min': state._min,
        'max': state._max,
      };
}
