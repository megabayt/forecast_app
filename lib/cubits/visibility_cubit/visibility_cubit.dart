import 'dart:async';

import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'visibility_state.dart';

class VisibilityCubit extends HydratedCubit<VisibilityState> {
  VisibilityCubit({required CommonSettingsCubit commonSettingsCubit})
      : super(VisibilityState(
            distanceUnit: commonSettingsCubit.state.distanceUnit)) {
    _commonSettingsSub = commonSettingsCubit.stream.listen((event) {
      emit(state.copyWith(
        distanceUnit: event.distanceUnit,
      ));
    });
  }

  StreamSubscription<CommonSettingsState>? _commonSettingsSub;

  @override
  close() async {
    if (_commonSettingsSub != null) {
      await _commonSettingsSub?.cancel();
    }
    super.close();
  }

  onValue(double newValue) {
    emit(state.copyWith(
      value: convertToDistanceUnit(
          newValue, DistanceUnit.meters, state.distanceUnit),
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
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson(VisibilityState state) => {
        'distanceUnit': state.distanceUnit.index,
        'minOn': state.minOn,
        'min': state.min,
        'value': state._value,
      };
}
