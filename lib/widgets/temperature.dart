import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:forecast_app/widgets/temperature_bottom_sheet.dart';

class Temperature extends StatelessWidget {
  const Temperature({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return BlocBuilder<CommonSettingsCubit, CommonSettingsState>(
          builder: (commonSettingsCubitContext, commonSettingsCubitState) {
            return BlocBuilder<TemperatureCubit, TemperatureState>(
              builder: (temperatureCubitContext, temperatureCubitState) {
                var temperatureString =
                    temperatureCubitState.value.toStringAsFixed(1);
                temperatureString +=
                    '°${temperatureCubitState.temperatureUnit == TemperatureUnit.celsius ? 'C' : 'F'}';

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
                        return const TemperatureBottomSheet();
                      },
                    );
                  },
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Температура",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          ...(commonBlocState.isFetching
                              ? [const CircularProgressIndicator()]
                              : [
                                  Text(
                                    temperatureString,
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
