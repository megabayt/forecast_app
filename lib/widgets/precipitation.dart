import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/mixins/precipitation_mixin.dart';
import 'package:forecast_app/widgets/precipitation_bottom_sheet.dart';

class Precipitation extends StatelessWidget with DateMixin, PrecipitationMixin {
  const Precipitation({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return buildPrecipitation(
          builder: (recommended, value) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return const PrecipitationBottomSheet();
                  },
                );
              },
              child: Card(
                elevation: 2,
                color: recommended ? Colors.white : Colors.red[300],
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
                              '${value.toStringAsFixed(0)}%',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
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
