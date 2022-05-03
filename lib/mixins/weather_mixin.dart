import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';

abstract class WeatherMixin implements DateMixin {
  Widget buildWeather({required Widget Function(int weather) builder}) {
    return BlocBuilder<WeatherCubit, WeatherState>(
        builder: (weatherContext, weatherCubitState) {
      return buildDate(builder: (DateTime date) {
        return builder(
            weatherCubitState.data[roundToNearest5String(date)] ?? 0);
      });
    });
  }
}
