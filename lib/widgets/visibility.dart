import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/mixins/common_settings_mixin.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/mixins/visibility_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:forecast_app/widgets/visibility_bottom_sheet.dart';

class Visibility extends StatelessWidget
    with DateMixin, CommonSettingsMixin, VisibilityMixin {
  const Visibility({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return buildVisibility(
          builder: (recommended, value, distanceUnit) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return const VisibilityBottomSheet();
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
                        "Видимость",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      commonBlocState.isFetching
                          ? const CircularProgressIndicator()
                          : Text(
                              value.toStringAsFixed(0) +
                                  getDistanceUnitLabel(
                                      distanceUnit == DistanceUnit.meters
                                          ? DistanceUnit.kilometers
                                          : DistanceUnit.miles),
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
