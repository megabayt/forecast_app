import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/cloudiness_cubit/cloudiness_cubit.dart';
import 'package:forecast_app/widgets/cloudiness_bottom_sheet.dart';

class Cloudiness extends StatelessWidget {
  const Cloudiness({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return BlocBuilder<CloudinessCubit, CloudinessState>(
          builder: (cloudinessCubitContext, cloudinessCubitState) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return const CloudinessBottomSheet();
                  },
                );
              },
              child: Card(
                elevation: 2,
                color: cloudinessCubitState.recommended
                    ? Colors.white
                    : Colors.red[300],
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Облачность",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      commonBlocState.isFetching
                          ? const CircularProgressIndicator()
                          : Text(
                              '${cloudinessCubitState.value.toStringAsFixed(0)}%',
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
