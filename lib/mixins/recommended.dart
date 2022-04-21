import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/cloudiness_cubit/cloudiness_cubit.dart';
import 'package:forecast_app/cubits/kpindex_cubit/kpindex_cubit.dart';
import 'package:forecast_app/cubits/precipitation_cubit/precipitation_cubit.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';
import 'package:forecast_app/cubits/visibility_cubit/visibility_cubit.dart';
import 'package:forecast_app/cubits/wind_cubit/wind_cubit.dart';

mixin RecommendedMixin on StatelessWidget {
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
      return temperatureCubitState.getRecommendedByDateRange(date1, date2) &&
          windCubitState.getRecommendedSpeedByDateRange(date1, date2) &&
          windCubitState.getRecommendedGustsByDateRange(date1, date2) &&
          precipitationCubitState.getRecommendedByDateRange(date1, date2) &&
          cloudinessCubitState.getRecommendedByDateRange(date1, date2) &&
          kpIndexCubitState.getRecommendedByDateRange(date1, date2) &&
          visibilityState.getRecommendedByDateRange(date1, date2);
    }
    return temperatureCubitState.getRecommendedByDate(date1) &&
        windCubitState.getRecommendedSpeedByDate(date1) &&
        windCubitState.getRecommendedGustsByDate(date1) &&
        precipitationCubitState.getRecommendedByDate(date1) &&
        cloudinessCubitState.getRecommendedByDate(date1) &&
        kpIndexCubitState.getRecommendedByDate(date1) &&
        visibilityState.getRecommendedByDate(date1);
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
