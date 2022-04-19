import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/cubits/wind_cubit/wind_cubit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:forecast_app/widgets/wind_bottom_sheet.dart';

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
                var windSpeedString = windCubitState.speed.toStringAsFixed(1);
                windSpeedString += getSpeedUnitLabel(windCubitState.speedUnit);

                var heightString = 'на ';
                heightString +=
                    commonSettingsCubitState.height.toStringAsFixed(0);
                heightString +=
                    getDistanceUnitLabel(commonSettingsCubitState.distanceUnit);

                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return const WindBottomSheet(
                          description: 'Скорость ветра',
                        );
                      },
                    );
                  },
                  child: Card(
                    elevation: 2,
                    color: windCubitState.recommended ? Colors.white : Colors.red[300],
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    heightString,
                                  ),
                                ]),
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
  }
}
