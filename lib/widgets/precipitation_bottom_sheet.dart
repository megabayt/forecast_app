import 'package:flutter/material.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/cubits/precipitation_cubit/precipitation_cubit.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrecipitationBottomSheet extends StatelessWidget {
  const PrecipitationBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonSettingsCubit, CommonSettingsState>(
        builder: (commonSettingsCubitContext, commonSettingsCubitState) {
      return BlocBuilder<PrecipitationCubit, PrecipitationState>(
          builder: (precipitationCubitContext, precipitationCubitState) {
        return Wrap(
          children: [
            ListTile(
              title: Text('Описание',
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            const ListTile(
              title: Text('Вероятность осадков'),
            ),
            ListTile(
              title: Text('Настройки',
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            SwitchListTile(
              title: const Text('Макс. вероятность осадков'),
              value: precipitationCubitState.maxOn,
              onChanged: (_) {
                context.read<PrecipitationCubit>().onToggleMax();
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: SfSlider(
                      value: precipitationCubitState.max,
                      min: 0,
                      max: 100,
                      showLabels: true,
                      onChanged: (newValue) {
                        context.read<PrecipitationCubit>().onChangeMax(
                              newValue,
                            );
                      },
                    ),
                  ),
                  Text((precipitationCubitState.max)
                          .floor()
                          .toString()
                          .padLeft(5, ' ') +
                      '%'),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
              width: 1,
            ),
          ],
        );
      });
    });
  }
}
