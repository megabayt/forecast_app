import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/sun_cubit/sun_cubit.dart';

class Sun extends StatelessWidget {
  const Sun({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return BlocBuilder<SunCubit, SunState>(
          builder: (sunCubitContext, sunCubitState) {
            return Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Солнце",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ...(commonBlocState.isFetching
                        ? [const CircularProgressIndicator()]
                        : [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.arrow_upward),
                                Text(sunCubitState.sunrise),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.arrow_downward),
                                Text(sunCubitState.sunset),
                              ],
                            ),
                          ])
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
