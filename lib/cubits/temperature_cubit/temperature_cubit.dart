import 'package:bloc/bloc.dart';
import 'package:forecast_app/cubits/settings_cubit/settings_cubit.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:meta/meta.dart';

part 'temperature_state.dart';

class TemperatureCubit extends Cubit<TemperatureState> {
  TemperatureCubit({
    required SettingsCubit settingsCubit,
  })  : _settingsCubit = settingsCubit,
        super(const TemperatureState());

  final SettingsCubit _settingsCubit;

  onValue(double newValue) {
    emit(state.copyWith(
      value: convertToTemperatureUnit(
          newValue, TemperatureUnit.celsius, _settingsCubit.state.temperatureUnit),
    ));
  }
}
