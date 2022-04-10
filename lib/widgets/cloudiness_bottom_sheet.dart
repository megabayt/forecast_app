import 'package:flutter/material.dart';
import 'package:forecast_app/cubits/cloudiness_cubit/cloudiness_cubit.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CloudinessBottomSheet extends StatelessWidget {
  const CloudinessBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CloudinessCubit, CloudinessState>(
        builder: (cloudinessCubitContext, cloudinessCubitState) {
      return Wrap(
        children: [
          ListTile(
            title: Text('Описание',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          const ListTile(
            title: Text('Облачность'),
          ),
          ListTile(
            title: Text('Настройки',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          SwitchListTile(
            title: const Text('Макс. облачность'),
            value: cloudinessCubitState.maxOn,
            onChanged: (_) {
              context.read<CloudinessCubit>().onToggleMax();
            },
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: SfSlider(
                    value: cloudinessCubitState.max,
                    min: 0,
                    max: 100,
                    showLabels: true,
                    onChanged: (newValue) {
                      context.read<CloudinessCubit>().onChangeMax(
                            newValue,
                          );
                    },
                  ),
                ),
                Text((cloudinessCubitState.max)
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
  }
}
