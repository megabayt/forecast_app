import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/bloc/weather_bloc.dart';

class Sun extends StatelessWidget {
  const Sun({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final sunriseStr = state.data?.data
            .firstWhere(
              (element) => element.parameter == 'sunrise:sql',
            )
            .coordinates
            .first
            .dates
            .first
            .value;
        final sunriseDate =
            sunriseStr != null ? DateTime.parse(sunriseStr) : null;
        final sunrise =
            '${sunriseDate?.hour.toString().padLeft(2, '0')}:${sunriseDate?.minute.toString().padLeft(2, '0')}';

        final sunsetStr = state.data?.data
            .firstWhere(
              (element) => element.parameter == 'sunset:sql',
            )
            .coordinates
            .first
            .dates
            .first
            .value;
        final sunsetDate = sunsetStr != null ? DateTime.parse(sunsetStr) : null;
        final sunset =
            '${sunsetDate?.hour.toString().padLeft(2, '0')}:${sunsetDate?.minute.toString().padLeft(2, '0')}';

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
                ...(state.isFetching
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
  }
}
