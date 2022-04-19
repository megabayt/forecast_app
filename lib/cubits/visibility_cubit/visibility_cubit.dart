import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/interfaces/common_info.dart';
import 'package:forecast_app/mixins/with_date.dart';
import 'package:forecast_app/mixins/with_distance_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

part 'visibility_state.dart';

class VisibilityCubit extends HydratedCubit<VisibilityState>
    with WithDistanceUnit, WithDate {
  VisibilityCubit({
    required CommonSettingsCubit commonSettingsCubit,
    required DateCubit dateCubit,
  }) : super(
          VisibilityState(
            distanceUnit: commonSettingsCubit.state.distanceUnit,
          ),
        ) {
    subDistanceUnit(commonSettingsCubit);
    subDate(dateCubit);
  }

  @override
  close() async {
    await unsubDate();
    await unsubDistanceUnit();
    super.close();
  }

  onData(List<Date> data) {
    emit(state.copyWith(
      data: data,
    ));
  }

  onChangeMin(double newMin) {
    emit(state.copyWith(
      min: newMin,
    ));
  }

  onToggleMin() {
    emit(state.copyWith(
      minOn: !state.minOn,
    ));
  }

  @override
  VisibilityState fromJson(Map<String, dynamic> json) => VisibilityState(
        distanceUnit: DistanceUnit.values.elementAt(json['distanceUnit']),
        minOn: json['minOn'],
        min: json['min'],
      );

  @override
  Map<String, dynamic> toJson(VisibilityState state) => {
        'distanceUnit': state.distanceUnit.index,
        'minOn': state.minOn,
        'min': state.min,
      };
}
