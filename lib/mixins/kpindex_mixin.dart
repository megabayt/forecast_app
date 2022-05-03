import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/kpindex_cubit/kpindex_cubit.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';

abstract class KpIndexMixin implements DateMixin {
  int getKpIndexValueByDate({
    required KpIndexState kpIndexState,
    required DateTime date,
  }) {
    return kpIndexState.data[roundToNearest5String(date)] ?? 0;
  }

  bool Function(DateTime date) getKpIndexRecommendedByDate(
          KpIndexState kpIndexState) =>
      (DateTime date) {
        final maxOn = kpIndexState.maxOn;
        final max = kpIndexState.max;
        final value =
            getKpIndexValueByDate(date: date, kpIndexState: kpIndexState);
        return !maxOn || value < max;
      };

  Widget buildKpIndex({
    required Widget Function(
      bool recommended,
      int value,
    )
        builder,
  }) {
    return BlocBuilder<KpIndexCubit, KpIndexState>(
        builder: (kpIndexContext, kpIndexCubitState) {
      return buildDate(builder: (DateTime date) {
        return builder(
          getKpIndexRecommendedByDate(kpIndexCubitState)(date),
          getKpIndexValueByDate(
            kpIndexState: kpIndexCubitState,
            date: date,
          ),
        );
      });
    });
  }
}
