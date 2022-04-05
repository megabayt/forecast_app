import 'package:forecast_app/enums/speed_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'wind_state.dart';

class WindCubit extends HydratedCubit<WindState> {
  WindCubit() : super(const WindState());

  onValue(double newValue) {
    emit(state.copyWith(
      value: convertToSpeedUnit(newValue, SpeedUnit.ms, state.speedUnit),
    ));
  }

  onChangeSpeedUnit(SpeedUnit newUnit) {
    emit(state.copyWith(
      speedUnit: newUnit,
    ));
  }

  @override
  WindState fromJson(Map<String, dynamic> json) => WindState(
        speedUnit: SpeedUnit.values.elementAt(json['SpeedUnit']),
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson(WindState state) => {
        'SpeedUnit': state.speedUnit.index,
        'value': state._value,
      };
}
