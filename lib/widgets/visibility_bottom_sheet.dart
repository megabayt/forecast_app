import 'package:flutter/material.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/cubits/visibility_cubit/visibility_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisibilityBottomSheet extends StatelessWidget {
  const VisibilityBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonSettingsCubit, CommonSettingsState>(
      builder: (commonSettingnsContext, commonSettingsState) {
        return BlocBuilder<VisibilityCubit, VisibilityState>(
            builder: (visibilityCubitContext, visibilityCubitState) {
          return Wrap(
            children: [
              ListTile(
                title: Text('Описание',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              const ListTile(
                title: Text('Видимость'),
              ),
              ListTile(
                title: Text('Настройки',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              SwitchListTile(
                title: const Text('Мин. видимость'),
                value: visibilityCubitState.minOn,
                onChanged: (_) {
                  context.read<VisibilityCubit>().onToggleMin();
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: SfSlider(
                        value: visibilityCubitState.min,
                        min: 0,
                        max: convertToDistanceUnit(50000, DistanceUnit.meters,
                            commonSettingsState.distanceUnit),
                        showLabels: true,
                        onChanged: (newValue) {
                          context.read<VisibilityCubit>().onChangeMin(
                                newValue,
                              );
                        },
                      ),
                    ),
                    Text((visibilityCubitState.min)
                            .floor()
                            .toString()
                            .padLeft(3, ' ') +
                        ' ${getDistanceUnitLabel(commonSettingsState.distanceUnit)}'),
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
                      child:
                          Text(getDistanceUnitLabel(DistanceUnit.kilometers)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(getDistanceUnitLabel(DistanceUnit.miles)),
                    ),
                  ],
                  constraints: BoxConstraints(
                      minWidth: (MediaQuery.of(context).size.width - 36) / 2),
                  isSelected: [
                    commonSettingsState.distanceUnit == DistanceUnit.meters,
                    commonSettingsState.distanceUnit == DistanceUnit.feet,
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
      },
    );
  }
}
