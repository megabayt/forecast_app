import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/bloc/weather_bloc.dart';

class Weather extends StatelessWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final weatherSymbol = state.data?.data
                .firstWhere(
                  (element) => element.parameter == 'weather_symbol_30min:idx',
                )
                .coordinates
                .first
                .dates
                .first
                .value ??
            0;

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
                state.isFetching
                    ? const CircularProgressIndicator()
                    : Image.asset('assets/weather_icons/$weatherSymbol.png'),
              ],
            ),
          ),
          color: Theme.of(context).cardColor,
        );
      },
    );
  }
}
