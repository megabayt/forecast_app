import 'package:flutter/material.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/cubits/wind_cubit/wind_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/enums/speed_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/location_bloc/location_bloc.dart';

class WindBottomSheet extends StatelessWidget {
  const WindBottomSheet({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonSettingsCubit, CommonSettingsState>(
        builder: (commonSettingsCubitContext, commonSettingsCubitState) {
      return BlocBuilder<WindCubit, WindState>(
          builder: (windCubitContext, windCubitState) {
        return BlocBuilder<LocationBloc, LocationState>(
            builder: (locationContext, locationState) {
          return Wrap(
            children: [
              ListTile(
                title: Text('Описание',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              ListTile(
                title: Text(description),
              ),
              ListTile(
                title: Text('Настройки',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              SwitchListTile(
                title: const Text('Макс. ветер'),
                value: windCubitState.maxOn,
                onChanged: (_) {
                  context.read<WindCubit>().onToggleMax();
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: SfSlider(
                        value: windCubitState.max,
                        min: convertToSpeedUnit(
                            0, SpeedUnit.ms, windCubitState.speedUnit),
                        max: convertToSpeedUnit(
                            40, SpeedUnit.ms, windCubitState.speedUnit),
                        showLabels: true,
                        onChanged: (newValue) {
                          context.read<WindCubit>().onChangeMax(
                                newValue,
                              );
                        },
                      ),
                    ),
                    Text((windCubitState.max)
                            .floor()
                            .toString()
                            .padLeft(5, ' ') +
                        ' ${getSpeedUnitLabel(windCubitState.speedUnit)}'),
                  ],
                ),
              ),
              SwitchListTile(
                title: const Text('Включить порывы'),
                value: windCubitState.gustsOn,
                onChanged: (_) {
                  context.read<WindCubit>().onToggleGusts();
                },
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
                          if (locationState.myLocation?.point != null) {
                            context.read<CommonBloc>().add(FetchAll(
                                point: locationState.myLocation!.point));
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(getSpeedUnitLabel(SpeedUnit.ms)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(getSpeedUnitLabel(SpeedUnit.kmh)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(getSpeedUnitLabel(SpeedUnit.mph)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(getSpeedUnitLabel(SpeedUnit.knots)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(getSpeedUnitLabel(SpeedUnit.bft)),
                    ),
                  ],
                  constraints: BoxConstraints(
                      minWidth: (MediaQuery.of(context).size.width - 44) / 5),
                  isSelected: [
                    windCubitState.speedUnit == SpeedUnit.ms,
                    windCubitState.speedUnit == SpeedUnit.kmh,
                    windCubitState.speedUnit == SpeedUnit.mph,
                    windCubitState.speedUnit == SpeedUnit.knots,
                    windCubitState.speedUnit == SpeedUnit.bft,
                  ],
                  onPressed: (index) {
                    SpeedUnit? unit;
                    if (index == 0) {
                      unit = SpeedUnit.ms;
                    } else if (index == 1) {
                      unit = SpeedUnit.kmh;
                    } else if (index == 2) {
                      unit = SpeedUnit.mph;
                    } else if (index == 3) {
                      unit = SpeedUnit.knots;
                    } else if (index == 4) {
                      unit = SpeedUnit.bft;
                    }
                    context.read<WindCubit>().onChangeSpeedUnit(unit!);
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
