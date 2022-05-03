import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/visibility_cubit/visibility_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/mixins/common_settings_mixin.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';

abstract class VisibilityMixin implements DateMixin, CommonSettingsMixin {
  double getVisibilityValueByDate({
    required VisibilityState visibilityState,
    required DistanceUnit distanceUnit,
    required DateTime date,
  }) {
    return convertToDistanceUnit(
        visibilityState.data[roundToNearest5String(date)] ?? 0,
        DistanceUnit.meters,
        distanceUnit == DistanceUnit.meters
            ? DistanceUnit.kilometers
            : DistanceUnit.miles);
  }

  bool Function(DateTime date) getVisibilityRecommendedByDate(
          VisibilityState visibilityState) =>
      (DateTime date) {
        final min = visibilityState.min;
        final minOn = visibilityState.minOn;
        final value = visibilityState.data[roundToNearest5String(date)] ?? 0;
        return !minOn || value > min;
      };

  Widget buildVisibility({
    required Widget Function(
      bool recommended,
      double value,
      DistanceUnit distanceUnit,
    )
        builder,
  }) {
    return BlocBuilder<VisibilityCubit, VisibilityState>(
        builder: (visibilityContext, visibilityCubitState) {
      return buildDate(builder: (DateTime date) {
        return buildCommonSettings(builder: ({
          required DistanceUnit distanceUnit,
          required double height,
        }) {
          return builder(
              getVisibilityRecommendedByDate(visibilityCubitState)(date),
              getVisibilityValueByDate(
                visibilityState: visibilityCubitState,
                distanceUnit: distanceUnit,
                date: date,
              ),
              distanceUnit == DistanceUnit.meters
                  ? DistanceUnit.kilometers
                  : DistanceUnit.miles);
        });
      });
    });
  }
}
