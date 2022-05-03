import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/utils/helpers.dart';

abstract class CommonSettingsMixin {
  Widget buildCommonSettings({
    required Widget Function({
      required DistanceUnit distanceUnit,
      required double height,
    })
        builder,
  }) {
    return BlocBuilder<CommonSettingsCubit, CommonSettingsState>(
        builder: (commonSettingsContext, commonSettingsCubitState) {
      return builder(
        distanceUnit: commonSettingsCubitState.distanceUnit,
        height: convertToDistanceUnit(
          commonSettingsCubitState.height,
          DistanceUnit.meters,
          commonSettingsCubitState.distanceUnit,
        ).floorToDouble(),
      );
    });
  }
}
