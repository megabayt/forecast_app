import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/mixins/sun_mixin.dart';

class Sun extends StatelessWidget with DateMixin, SunMixin {
  const Sun({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return buildSun(
          builder: ({required sunrise, required sunset}) {
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
                                Text(sunrise),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.arrow_downward),
                                Text(sunset),
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
