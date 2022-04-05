import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/cubits/cubit/wind_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/utils/helpers.dart';

class WindSpeed extends StatelessWidget {
  const WindSpeed({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return BlocBuilder<CommonSettingsCubit, CommonSettingsState>(
          builder: (commonSettingsCubitContext, commonSettingsCubitState) {
            return BlocBuilder<WindCubit, WindState>(
              builder: (windCubitContext, windCubitState) {
                var windSpeedString = windCubitState.value.toStringAsFixed(1);
                windSpeedString += getSpeedUnitLabel(windCubitState.speedUnit);

                var heightString = 'на ';
                heightString +=
                    commonSettingsCubitState.height.toStringAsFixed(0);
                heightString +=
                    commonSettingsCubitState.distanceUnit == DistanceUnit.feet
                        ? ' feet'
                        : ' m';

                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Ветер",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        ...(commonBlocState.isFetching
                            ? [const CircularProgressIndicator()]
                            : [
                                Text(
                                  windSpeedString,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  heightString,
                                ),
                              ]),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
