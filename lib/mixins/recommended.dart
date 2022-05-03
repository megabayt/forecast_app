import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/cloudiness_cubit/cloudiness_cubit.dart';
import 'package:forecast_app/cubits/kpindex_cubit/kpindex_cubit.dart';
import 'package:forecast_app/cubits/precipitation_cubit/precipitation_cubit.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';
import 'package:forecast_app/cubits/visibility_cubit/visibility_cubit.dart';
import 'package:forecast_app/cubits/wind_cubit/wind_cubit.dart';
import 'package:forecast_app/mixins/cloudiness_mixin.dart';
import 'package:forecast_app/mixins/common_settings_mixin.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/mixins/kpindex_mixin.dart';
import 'package:forecast_app/mixins/precipitation_mixin.dart';
import 'package:forecast_app/mixins/temperature_mixin.dart';
import 'package:forecast_app/mixins/visibility_mixin.dart';
import 'package:forecast_app/mixins/wind_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';

abstract class RecommendedMixin
    implements
        DateMixin,
        CommonSettingsMixin,
        TemperatureMixin,
        WindMixin,
        PrecipitationMixin,
        CloudinessMixin,
        KpIndexMixin,
        VisibilityMixin {
  bool _getRecommendedInternal({
    required TemperatureState temperatureCubitState,
    required WindState windCubitState,
    required PrecipitationState precipitationCubitState,
    required CloudinessState cloudinessCubitState,
    required KpIndexState kpIndexCubitState,
    required VisibilityState visibilityState,
    required DateTime date1,
    DateTime? date2,
  }) {
    if (date2 != null) {
      return getRecommendedByDateRange(date1, date2,
              getTemperatureRecommendedByDate(temperatureCubitState)) &&
          getRecommendedByDateRange(
              date1, date2, getSpeedRecommendedByDate(windCubitState)) &&
          getRecommendedByDateRange(
              date1, date2, getGustsRecommendedByDate(windCubitState)) &&
          getRecommendedByDateRange(date1, date2,
              getPrecipitationRecommendedByDate(precipitationCubitState)) &&
          getRecommendedByDateRange(date1, date2,
              getCloudinessRecommendedByDate(cloudinessCubitState)) &&
          getRecommendedByDateRange(
              date1, date2, getKpIndexRecommendedByDate(kpIndexCubitState)) &&
          getRecommendedByDateRange(
              date1, date2, getVisibilityRecommendedByDate(visibilityState));
    }
    return getTemperatureRecommendedByDate(temperatureCubitState)(date1) &&
        getSpeedRecommendedByDate(windCubitState)(date1) &&
        getGustsRecommendedByDate(windCubitState)(date1) &&
        getPrecipitationRecommendedByDate(precipitationCubitState)(date1) &&
        getCloudinessRecommendedByDate(cloudinessCubitState)(date1) &&
        getKpIndexRecommendedByDate(kpIndexCubitState)(date1) &&
        getVisibilityRecommendedByDate(visibilityState)(date1);
  }

  bool Function(DateTime date1, [DateTime? date2]) _getRecommended({
    required TemperatureState temperatureCubitState,
    required WindState windCubitState,
    required PrecipitationState precipitationCubitState,
    required CloudinessState cloudinessCubitState,
    required KpIndexState kpIndexCubitState,
    required VisibilityState visibilityState,
  }) =>
      (DateTime date1, [DateTime? date2]) {
        return _getRecommendedInternal(
          temperatureCubitState: temperatureCubitState,
          windCubitState: windCubitState,
          precipitationCubitState: precipitationCubitState,
          cloudinessCubitState: cloudinessCubitState,
          kpIndexCubitState: kpIndexCubitState,
          visibilityState: visibilityState,
          date1: date1,
          date2: date2,
        );
      };

  Widget buildRecommended({
    required Widget Function(bool Function(DateTime date1, [DateTime? date2]))
        builder,
  }) {
    return BlocBuilder<TemperatureCubit, TemperatureState>(
        builder: (temperatureContext, temperatureCubitState) {
      return BlocBuilder<WindCubit, WindState>(
          builder: (windContext, windCubitState) {
        return BlocBuilder<PrecipitationCubit, PrecipitationState>(
            builder: (precipitationContext, precipitationCubitState) {
          return BlocBuilder<CloudinessCubit, CloudinessState>(
              builder: (cloudinessContext, cloudinessCubitState) {
            return BlocBuilder<KpIndexCubit, KpIndexState>(
                builder: (kpIndexContext, kpIndexCubitState) {
              return BlocBuilder<VisibilityCubit, VisibilityState>(
                  builder: (visibilityContext, visibilityState) {
                return builder(_getRecommended(
                  temperatureCubitState: temperatureCubitState,
                  windCubitState: windCubitState,
                  precipitationCubitState: precipitationCubitState,
                  cloudinessCubitState: cloudinessCubitState,
                  kpIndexCubitState: kpIndexCubitState,
                  visibilityState: visibilityState,
                ));
              });
            });
          });
        });
      });
    });
  }
}
