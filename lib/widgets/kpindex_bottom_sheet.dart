import 'package:flutter/material.dart';
import 'package:forecast_app/cubits/kpindex_cubit/kpindex_cubit.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KpIndexBottomSheet extends StatelessWidget {
  const KpIndexBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KpIndexCubit, KpIndexState>(
        builder: (kpIndexCubitContext, kpIndexCubitState) {
      return Wrap(
        children: [
          ListTile(
            title: Text('Описание',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          const ListTile(
            title: Text('Kp-индекс'),
          ),
          ListTile(
            title: Text('Настройки',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          SwitchListTile(
            title: const Text('Макс. Kp-индекс'),
            value: kpIndexCubitState.maxOn,
            onChanged: (_) {
              context.read<KpIndexCubit>().onToggleMax();
            },
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: SfSlider(
                    value: kpIndexCubitState.max,
                    min: 0,
                    max: 9,
                    showLabels: true,
                    onChanged: (newValue) {
                      context.read<KpIndexCubit>().onChangeMax(
                            newValue.toInt(),
                          );
                    },
                  ),
                ),
                Text(kpIndexCubitState.max.toString()),
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
