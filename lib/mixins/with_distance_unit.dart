import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/enums/distance_unit.dart';

mixin WithDistanceUnit<T extends WithDistanceUnitState> on Cubit<T> {
  StreamSubscription<CommonSettingsState>? _sub;

  void subDistanceUnit(CommonSettingsCubit commonSettingsCubit) {
    _sub = commonSettingsCubit.stream.listen((event) {
      emit(state.copyWith(
        distanceUnit: event.distanceUnit,
      ) as T);
    });
  }

  Future<void> unsubDistanceUnit() async {
    if (_sub != null) {
      await _sub!.cancel();
    }
  }
}


abstract class WithDistanceUnitState {
  const WithDistanceUnitState({this.distanceUnit = DistanceUnit.meters});

  final DistanceUnit distanceUnit;

  WithDistanceUnitState copyWith({
    DistanceUnit distanceUnit,
  });
}
