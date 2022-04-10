import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/cubits/visibility_cubit/visibility_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:forecast_app/widgets/visibility_bottom_sheet.dart';

class Visibility extends StatelessWidget {
  const Visibility({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return BlocBuilder<CommonSettingsCubit, CommonSettingsState>(
          builder: (commonSettingsContext, commonSettingsState) {
            return BlocBuilder<VisibilityCubit, VisibilityState>(
              builder: (cloudinessCubitContext, cloudinessCubitState) {
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
                                  cloudinessCubitState.valueInKmOrMiles
                                          .toStringAsFixed(0) +
                                      getDistanceUnitLabel(
                                          commonSettingsState.distanceUnit ==
                                                  DistanceUnit.meters
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
      },
    );
  }
}
