import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';

class Temperature extends StatelessWidget {
  const Temperature({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return BlocBuilder<TemperatureCubit, TemperatureState>(
          builder: (temperatureCubitContext, temperatureCubitState) {
            var temperatureString =
                temperatureCubitState.value?.toString() ?? '';
            temperatureString +=
                '°${temperatureCubitState.unit == Unit.celsius ? 'C' : 'F'}';

            return Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Температура",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    commonBlocState.isFetching
                        ? const CircularProgressIndicator()
                        : Text(
                            temperatureString,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
