import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/wind_cubit/wind_cubit.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/enums/speed_unit.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';

abstract class WindMixin implements DateMixin {
  double _getMax(
    WindState windState,
    DateTime date,
  ) {
    final max = windState.max;
    final speedUnit = windState.speedUnit;
    return convertToSpeedUnit(max, SpeedUnit.ms, speedUnit).floorToDouble();
  }

  double getDirectionByDate(
    WindState windState,
    DateTime date,
  ) {
    return windState.directionData[roundToNearest5String(date)] ?? 0;
  }

  double getSpeedByDate(
    WindState windState,
    DateTime date,
  ) {
    return convertToSpeedUnit(
      windState.speedData[roundToNearest5String(date)] ?? 0,
      SpeedUnit.ms,
      windState.speedUnit,
    );
  }

  double getGustsByDate(
    WindState windState,
    DateTime date,
  ) {
    return convertToSpeedUnit(
      windState.gustsData[roundToNearest5String(date)] ?? 0,
      SpeedUnit.ms,
      windState.speedUnit,
    );
  }

  bool Function(DateTime date) getSpeedRecommendedByDate(WindState windState) =>
      (DateTime date) {
        final maxOn = windState.maxOn;
        final max = _getMax(windState, date);
        final value = getSpeedByDate(windState, date);
        if (maxOn && value >= max) {
          return false;
        }
        return true;
      };

  bool Function(DateTime date) getGustsRecommendedByDate(WindState windState) =>
      (DateTime date) {
        final gustsOn = windState.gustsOn;
        final maxOn = windState.maxOn;
        final max = _getMax(windState, date);
        final value = getGustsByDate(windState, date);
        if (gustsOn && maxOn && value >= max) {
          return false;
        }
        return true;
      };

  Widget buildWind({
    required Widget Function({
      required double direction,
      required bool recommendedSpeed,
      required double speed,
      required bool recommendedGusts,
      required double gusts,
      required double height,
      required SpeedUnit speedUnit,
      required DistanceUnit distanceUnit,
    })
        builder,
  }) {
    return BlocBuilder<WindCubit, WindState>(
        builder: (windContext, windCubitState) {
      return BlocBuilder<CommonSettingsCubit, CommonSettingsState>(
          builder: (commonSettingsContext, commonSettingsCubitState) {
        return buildDate(builder: (DateTime date) {
          return builder(
            direction: getDirectionByDate(windCubitState, date),
            recommendedSpeed: getSpeedRecommendedByDate(windCubitState)(date),
            speed: getSpeedByDate(windCubitState, date),
            recommendedGusts: getGustsRecommendedByDate(windCubitState)(date),
            gusts: getGustsByDate(windCubitState, date),
            height: commonSettingsCubitState.height,
            speedUnit: windCubitState.speedUnit,
            distanceUnit: commonSettingsCubitState.distanceUnit,
          );
        });
      });
    });
  }
}
