import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/mixins/temperature_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:forecast_app/widgets/temperature_bottom_sheet.dart';

class Temperature extends StatelessWidget with DateMixin, TemperatureMixin {
  const Temperature({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return BlocBuilder<CommonSettingsCubit, CommonSettingsState>(
          builder: (commonSettingsCubitContext, commonSettingsCubitState) {
            return buildTemperature(
              builder: (recommended, value, temperatureUnit) {
                var temperatureString = value.toStringAsFixed(1);
                temperatureString +=
                    '°${temperatureUnit == TemperatureUnit.celsius ? 'C' : 'F'}';

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
                    color: recommended ? Colors.white : Colors.red[300],
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
