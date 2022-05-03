import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/precipitation_cubit/precipitation_cubit.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';

abstract class PrecipitationMixin implements DateMixin {
  double getPrecipitationValueByDate({
    required PrecipitationState precipitationState,
    required DateTime date,
  }) {
    return precipitationState.data[roundToNearest5String(date)] ?? 0;
  }

  bool Function(DateTime date) getPrecipitationRecommendedByDate(
          PrecipitationState precipitationState) =>
      (DateTime date) {
        final maxOn = precipitationState.maxOn;
        final max = precipitationState.max;
        final value = getPrecipitationValueByDate(
            date: date, precipitationState: precipitationState);
        return !maxOn || value < max;
      };

  Widget buildPrecipitation({
    required Widget Function(
      bool recommended,
      double value,
    )
        builder,
  }) {
    return BlocBuilder<PrecipitationCubit, PrecipitationState>(
        builder: (precipitationContext, precipitationCubitState) {
      return buildDate(builder: (DateTime date) {
        return builder(
          getPrecipitationRecommendedByDate(precipitationCubitState)(date),
          getPrecipitationValueByDate(
            precipitationState: precipitationCubitState,
            date: date,
          ),
        );
      });
    });
  }
}
