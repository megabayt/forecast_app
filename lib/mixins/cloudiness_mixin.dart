import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/cloudiness_cubit/cloudiness_cubit.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';

abstract class CloudinessMixin implements DateMixin {
  double getCloudinessValueByDate({
    required CloudinessState cloudinessState,
    required DateTime date,
  }) {
    return cloudinessState.data[roundToNearest5String(date)] ?? 0;
  }

  bool Function(DateTime date) getCloudinessRecommendedByDate(
          CloudinessState cloudinessState) =>
      (DateTime date) {
        final maxOn = cloudinessState.maxOn;
        final max = cloudinessState.max;
        final value = getCloudinessValueByDate(
            date: date, cloudinessState: cloudinessState);
        return !maxOn || value < max;
      };

  Widget buildCloudiness({
    required Widget Function(
      bool recommended,
      double value,
    )
        builder,
  }) {
    return BlocBuilder<CloudinessCubit, CloudinessState>(
        builder: (cloudinessContext, cloudinessCubitState) {
      return buildDate(builder: (DateTime date) {
        return builder(
          getCloudinessRecommendedByDate(cloudinessCubitState)(date),
          getCloudinessValueByDate(
            cloudinessState: cloudinessCubitState,
            date: date,
          ),
        );
      });
    });
  }
}
