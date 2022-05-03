import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/sun_cubit/sun_cubit.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';

abstract class SunMixin implements DateMixin {
  String _getSunrise(
    SunState sunState,
    DateTime date,
  ) {
    final sunriseStr = sunState.sunrises[roundToNearest5String(date)];
    if (sunriseStr == null) {
      return '';
    }
    final sunriseDate = DateTime.parse(sunriseStr);
    return '${sunriseDate.hour.toString().padLeft(2, '0')}:${sunriseDate.minute.toString().padLeft(2, '0')}';
  }

  String _getSunset(
    SunState sunState,
    DateTime date,
  ) {
    final sunsetStr = sunState.sunsets[roundToNearest5String(date)];
    if (sunsetStr == null) {
      return '';
    }
    final sunsetDate = DateTime.parse(sunsetStr);
    return '${sunsetDate.hour.toString().padLeft(2, '0')}:${sunsetDate.minute.toString().padLeft(2, '0')}';
  }

  Widget buildSun(
      {required Widget Function({
        required String sunrise,
        required String sunset,
      })
          builder}) {
    return BlocBuilder<SunCubit, SunState>(
        builder: (sunContext, sunCubitState) {
      return buildDate(builder: (DateTime date) {
        return builder(
          sunrise: _getSunrise(sunCubitState, date),
          sunset: _getSunset(sunCubitState, date),
        );
      });
    });
  }
}
