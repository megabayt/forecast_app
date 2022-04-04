import 'package:flutter/material.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';

class TemperatureBottomSheet extends StatelessWidget {
  const TemperatureBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemperatureCubit, TemperatureState>(
        builder: (temperatureCubitContext, temperatureCubitState) {
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
                    min: convertToUnit(-50, TemperatureUnit.celsius,
                        temperatureCubitState.unit),
                    max: convertToUnit(50, TemperatureUnit.celsius,
                        temperatureCubitState.unit),
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
                    ' ${temperatureCubitState.unit == TemperatureUnit.celsius ? 'C' : 'F'}'),
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
                    min: convertToUnit(-50, TemperatureUnit.celsius,
                        temperatureCubitState.unit),
                    max: convertToUnit(50, TemperatureUnit.celsius,
                        temperatureCubitState.unit),
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
                    ' ${temperatureCubitState.unit == TemperatureUnit.celsius ? 'C' : 'F'}'),
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
                temperatureCubitState.unit == TemperatureUnit.celsius,
                temperatureCubitState.unit == TemperatureUnit.farenheight,
              ],
              onPressed: (index) {
                context.read<TemperatureCubit>().onChangeUnit(
                      index == 0
                          ? TemperatureUnit.celsius
                          : TemperatureUnit.farenheight,
                    );
              },
            ),
          )
        ],
      );
    });
  }
}
