import 'package:flutter/material.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';
import 'package:forecast_app/blocs/location_bloc/location_bloc.dart';

class TemperatureBottomSheet extends StatelessWidget {
  const TemperatureBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonSettingsCubit, CommonSettingsState>(
        builder: (commonSettingsCubitContext, commonSettingsCubitState) {
      return BlocBuilder<TemperatureCubit, TemperatureState>(
          builder: (temperatureCubitContext, temperatureCubitState) {
        return BlocBuilder<LocationBloc, LocationState>(
            builder: (locationContext, locationState) {
          return Wrap(
            children: [
              ListTile(
                title: Text('Описание',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              const ListTile(
                title: Text('Температура воздуха'),
              ),
              ListTile(
                title: Text('Настройки',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              SwitchListTile(
                title: const Text('Мин. температура'),
                value: temperatureCubitState.minOn,
                onChanged: (_) {
                  context.read<TemperatureCubit>().onToggleMin();
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: SfSlider(
                        value: temperatureCubitState.min,
                        min: convertToTemperatureUnit(
                            -50,
                            TemperatureUnit.celsius,
                            temperatureCubitState.temperatureUnit),
                        max: convertToTemperatureUnit(
                            50,
                            TemperatureUnit.celsius,
                            temperatureCubitState.temperatureUnit),
                        showLabels: true,
                        onChanged: (newValue) {
                          context.read<TemperatureCubit>().onChangeMin(
                                newValue,
                              );
                        },
                      ),
                    ),
                    Text((temperatureCubitState.min)
                            .floor()
                            .toString()
                            .padLeft(3, ' ') +
                        ' ${temperatureCubitState.temperatureUnit == TemperatureUnit.celsius ? 'C' : 'F'}'),
                  ],
                ),
              ),
              SwitchListTile(
                title: const Text('Макс. температура'),
                value: temperatureCubitState.maxOn,
                onChanged: (_) {
                  context.read<TemperatureCubit>().onToggleMax();
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: SfSlider(
                        value: temperatureCubitState.max,
                        min: convertToTemperatureUnit(
                            -50,
                            TemperatureUnit.celsius,
                            temperatureCubitState.temperatureUnit),
                        max: convertToTemperatureUnit(
                            50,
                            TemperatureUnit.celsius,
                            temperatureCubitState.temperatureUnit),
                        showLabels: true,
                        onChanged: (newValue) {
                          context.read<TemperatureCubit>().onChangeMax(
                                newValue,
                              );
                        },
                      ),
                    ),
                    Text((temperatureCubitState.max)
                            .floor()
                            .toString()
                            .padLeft(3, ' ') +
                        ' ${temperatureCubitState.temperatureUnit == TemperatureUnit.celsius ? 'C' : 'F'}'),
                  ],
                ),
              ),
              const ListTile(
                title: Text('Высота'),
              ),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: SfSlider(
                        value: commonSettingsCubitState.height,
                        min: convertToDistanceUnit(0, DistanceUnit.meters,
                                commonSettingsCubitState.distanceUnit)
                            .floorToDouble(),
                        max: convertToDistanceUnit(5000, DistanceUnit.meters,
                                commonSettingsCubitState.distanceUnit)
                            .floorToDouble(),
                        showLabels: true,
                        onChanged: (newValue) {
                          context.read<CommonSettingsCubit>().onChangeHeight(
                                newValue,
                              );
                          if (locationState.myLocation?.position != null) {
                            context.read<CommonBloc>().add(FetchAll(
                                position: locationState.myLocation!.position));
                          }
                        },
                      ),
                    ),
                    Text((commonSettingsCubitState.height)
                            .floor()
                            .toString()
                            .padLeft(5, ' ') +
                        ' ${getDistanceUnitLabel(commonSettingsCubitState.distanceUnit)}'
                            .padLeft(5, ' ')),
                  ],
                ),
              ),
              ListTile(
                title: Text('Единицы измерения',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              ListTile(
                title: ToggleButtons(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('C'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('F'),
                    ),
                  ],
                  constraints: BoxConstraints(
                      minWidth: (MediaQuery.of(context).size.width - 36) / 2),
                  isSelected: [
                    temperatureCubitState.temperatureUnit ==
                        TemperatureUnit.celsius,
                    temperatureCubitState.temperatureUnit ==
                        TemperatureUnit.farenheight,
                  ],
                  onPressed: (index) {
                    context.read<TemperatureCubit>().onChangeTemperatureUnit(
                          index == 0
                              ? TemperatureUnit.celsius
                              : TemperatureUnit.farenheight,
                        );
                  },
                ),
              ),
              ListTile(
                title: ToggleButtons(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(getDistanceUnitLabel(DistanceUnit.meters)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(getDistanceUnitLabel(DistanceUnit.feet)),
                    ),
                  ],
                  constraints: BoxConstraints(
                      minWidth: (MediaQuery.of(context).size.width - 36) / 2),
                  isSelected: [
                    commonSettingsCubitState.distanceUnit ==
                        DistanceUnit.meters,
                    commonSettingsCubitState.distanceUnit == DistanceUnit.feet,
                  ],
                  onPressed: (index) {
                    context.read<CommonSettingsCubit>().onChangeDistanceUnit(
                          index == 0 ? DistanceUnit.meters : DistanceUnit.feet,
                        );
                  },
                ),
              ),
            ],
          );
        });
      });
    });
  }
}
