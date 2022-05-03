import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';

abstract class TemperatureMixin implements DateMixin {
  double _getMin({
    required TemperatureState temperatureState,
    required DateTime date,
  }) {
    final min = temperatureState.min;
    final temperatureUnit = temperatureState.temperatureUnit;
    return convertToTemperatureUnit(
            min, TemperatureUnit.celsius, temperatureUnit)
        .floorToDouble();
  }

  double _getMax({
    required TemperatureState temperatureState,
    required DateTime date,
  }) {
    final max = temperatureState.max;
    final temperatureUnit = temperatureState.temperatureUnit;
    return convertToTemperatureUnit(
            max, TemperatureUnit.celsius, temperatureUnit)
        .floorToDouble();
  }

  double getTemperatureValueByDate({
    required TemperatureState temperatureState,
    required DateTime date,
  }) {
    return convertToTemperatureUnit(
        temperatureState.data[roundToNearest5String(date)] ?? 0,
        TemperatureUnit.celsius,
        temperatureState.temperatureUnit);
  }

  bool Function(DateTime date) getTemperatureRecommendedByDate(
          TemperatureState temperatureState) =>
      (DateTime date) {
        final max = _getMax(temperatureState: temperatureState, date: date);
        final maxOn = temperatureState.maxOn;
        final min = _getMin(temperatureState: temperatureState, date: date);
        final minOn = temperatureState.minOn;
        final value = getTemperatureValueByDate(
          temperatureState: temperatureState,
          date: date,
        );
        final condition1 = maxOn && value >= max;
        final condition2 = minOn && value <= min;

        return !condition1 && !condition2;
      };

  Widget buildTemperature({
    required Widget Function(
      bool recommended,
      double value,
      TemperatureUnit temperatureUnit,
    )
        builder,
  }) {
    return BlocBuilder<TemperatureCubit, TemperatureState>(
        builder: (temperatureContext, temperatureCubitState) {
      return buildDate(builder: (DateTime date) {
        return builder(
          getTemperatureRecommendedByDate(temperatureCubitState)(date),
          getTemperatureValueByDate(
            temperatureState: temperatureCubitState,
            date: date,
          ),
          temperatureCubitState.temperatureUnit,
        );
      });
    });
  }
}
