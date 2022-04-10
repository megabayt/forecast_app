import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/precipitation_cubit/precipitation_cubit.dart';

class Precipitation extends StatelessWidget {
  const Precipitation({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return BlocBuilder<PrecipitationCubit, PrecipitationState>(
          builder: (precipitationCubitContext, precipitationCubitState) {
            return Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Вероятн. осадков",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    commonBlocState.isFetching
                        ? const CircularProgressIndicator()
                        : Text(
                            '${precipitationCubitState.value.toStringAsFixed(0)}%',
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
