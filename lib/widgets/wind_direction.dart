import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/cubit/wind_cubit.dart';
import 'package:forecast_app/widgets/compass_painter.dart';

class WindDirection extends StatelessWidget {
  const WindDirection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return BlocBuilder<WindCubit, WindState>(
          builder: (windCubitContext, windCubitState) {
            return Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Направл. ветра",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 5,
                      width: 5,
                    ),
                    commonBlocState.isFetching
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: 60,
                            height: 60,
                            child: CustomPaint(
                              painter: CompassPainter(
                                  rotate: windCubitState.direction),
                            ),
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
