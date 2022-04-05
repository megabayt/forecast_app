import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ThresholdSettings extends StatelessWidget {
  const ThresholdSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemperatureCubit, TemperatureState>(
      builder: (temperatureCubitContext, temperatureCubitState) {
        return Wrap(
          children: [
            const ListTile(
              title: Text('Высота'),
            ),
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: SfSlider(
                      value: temperatureCubitState.height,
                      min: convertToDistanceUnit(0, DistanceUnit.meters,
                              temperatureCubitState.distanceUnit)
                          .floorToDouble(),
                      max: convertToDistanceUnit(5000, DistanceUnit.meters,
                              temperatureCubitState.distanceUnit)
                          .floorToDouble(),
                      showLabels: true,
                      onChanged: (newValue) {
                        context.read<TemperatureCubit>().onChangeHeight(
                              newValue,
                            );
                      },
                    ),
                  ),
                  Text((temperatureCubitState.height)
                          .floor()
                          .toString()
                          .padLeft(5, ' ') +
                      ' ${temperatureCubitState.distanceUnit == DistanceUnit.meters ? 'm' : 'feet'}'
                          .padLeft(5, ' ')),
                ],
              ),
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
                      max: convertToTemperatureUnit(50, TemperatureUnit.celsius,
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
                      max: convertToTemperatureUnit(50, TemperatureUnit.celsius,
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
          ],
        );
      },
    );
  }
}
