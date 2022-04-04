import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/weather_cubit/weather_cubit.dart';

class Weather extends StatelessWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return BlocBuilder<WeatherCubit, int>(
          builder: (weatherCubitContext, weatherCubitState) {
            final weatherSymbol = weatherCubitState;

            return Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Погода',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    commonBlocState.isFetching
                        ? const CircularProgressIndicator()
                        : Image.asset(
                            'assets/weather_icons/$weatherSymbol.png'),
                  ],
                ),
              ),
              color: Theme.of(context).cardColor,
            );
          },
        );
      },
    );
  }
}
