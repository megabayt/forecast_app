import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/enums/temperature_unit.dart';

class UnitSettings extends StatelessWidget {
  const UnitSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemperatureCubit, TemperatureState>(
        builder: (temperatureCubitContext, temperatureCubitState) {
      return Wrap(
        children: [
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
              children: const [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('m'),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('feet'),
                ),
              ],
              constraints: BoxConstraints(
                  minWidth: (MediaQuery.of(context).size.width - 36) / 2),
              isSelected: [
                temperatureCubitState.distanceUnit == DistanceUnit.meters,
                temperatureCubitState.distanceUnit == DistanceUnit.feet,
              ],
              onPressed: (index) {
                context.read<TemperatureCubit>().onChangeDistanceUnit(
                      index == 0 ? DistanceUnit.meters : DistanceUnit.feet,
                    );
              },
            ),
          ),
        ],
      );
    });
  }
}
