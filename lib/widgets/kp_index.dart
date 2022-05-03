import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/mixins/kpindex_mixin.dart';
import 'package:forecast_app/widgets/kpindex_bottom_sheet.dart';

class KpIndex extends StatelessWidget with DateMixin, KpIndexMixin {
  const KpIndex({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (commonBlocContext, commonBlocState) {
        return buildKpIndex(
          builder: (recommended, value) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return const KpIndexBottomSheet();
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
                        "Kp-индекс",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      commonBlocState.isFetching
                          ? const CircularProgressIndicator()
                          : Text(
                              value.toString(),
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
