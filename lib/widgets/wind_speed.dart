import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/mixins/wind_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:forecast_app/widgets/wind_bottom_sheet.dart';

class WindSpeed extends StatelessWidget with DateMixin, WindMixin {
  const WindSpeed({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return buildWind(
          builder: ({
            required direction,
            required distanceUnit,
            required gusts,
            required height,
            required recommendedGusts,
            required recommendedSpeed,
            required speed,
            required speedUnit,
          }) {
            var windSpeedString = speed.toStringAsFixed(1);
            windSpeedString += getSpeedUnitLabel(speedUnit);

            var heightString = 'на ';
            heightString += height.toStringAsFixed(0);
            heightString += getDistanceUnitLabel(distanceUnit);

            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return const WindBottomSheet(
                      description: 'Скорость ветра',
                    );
                  },
                );
              },
              child: Card(
                elevation: 2,
                color: recommendedSpeed ? Colors.white : Colors.red[300],
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Ветер",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      ...(commonBlocState.isFetching
                          ? [const CircularProgressIndicator()]
                          : [
                              Text(
                                windSpeedString,
                                style: Theme.of(context).textTheme.titleLarge,
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
  }
}
