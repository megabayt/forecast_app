import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/cloudiness_cubit/cloudiness_cubit.dart';
import 'package:forecast_app/cubits/kpindex_cubit/kpindex_cubit.dart';
import 'package:forecast_app/cubits/precipitation_cubit/precipitation_cubit.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';
import 'package:forecast_app/cubits/visibility_cubit/visibility_cubit.dart';
import 'package:forecast_app/cubits/wind_cubit/wind_cubit.dart';

class Recommendation extends StatelessWidget {
  const Recommendation({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
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
                            final recommended =
                                temperatureCubitState.recommended &&
                                    windCubitState.recommendedSpeed &&
                                    windCubitState.recommendedGusts &&
                                    precipitationCubitState.recommended &&
                                    cloudinessCubitState.recommended &&
                                    kpIndexCubitState.recommended &&
                                    visibilityState.recommended;

                            return Card(
                              elevation: 2,
                              color:
                                  recommended ? Colors.white : Colors.red[300],
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Text(
                                        recommended
                                            ? "Можно летать"
                                            : "Не советуем летать",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(width: 8),
                                      recommended
                                          ? const Icon(
                                              Icons.check_box,
                                              color: Colors.lightGreen,
                                            )
                                          : const Icon(
                                              Icons.warning,
                                              color: Colors.amber,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
