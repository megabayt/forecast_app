import 'package:forecast_app/enums/speed_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'wind_state.dart';

class WindCubit extends HydratedCubit<WindState> {
  WindCubit() : super(const WindState());

  onChangeDirection(double newValue) {
    emit(state.copyWith(
      direction: newValue,
    ));
  }

  onChangeSpeed(double newValue) {
    emit(state.copyWith(
      speed: convertToSpeedUnit(newValue, SpeedUnit.ms, state.speedUnit),
    ));
  }

  onChangeGusts(double newValue) {
    emit(state.copyWith(
      gusts: convertToSpeedUnit(newValue, SpeedUnit.ms, state.speedUnit),
    ));
  }

  onChangeSpeedUnit(SpeedUnit newUnit) {
    emit(state.copyWith(
      speedUnit: newUnit,
    ));
  }

  onToggleGusts() {
    emit(state.copyWith(
      gustsOn: !state.gustsOn,
    ));
  }


  onChangeMax(double newMax) {
    emit(state.copyWith(
      max: newMax,
    ));
  }

  onToggleMax() {
    emit(state.copyWith(
      maxOn: !state.maxOn,
    ));
  }
  
  @override
  WindState fromJson(Map<String, dynamic> json) => WindState(
        direction: json['direction'],
        speedUnit: SpeedUnit.values.elementAt(json['SpeedUnit']),
        speed: json['speed'],
        gusts: json['gusts'],
        gustsOn: json['gustsOn'],
        maxOn: json['maxOn'],
        max: json['max'],
      );

  @override
  Map<String, dynamic> toJson(WindState state) => {
        'direction': state.direction,
        'SpeedUnit': state.speedUnit.index,
        'speed': state._speed,
        'gusts': state._gusts,
        'gustsOn': state.gustsOn,
        'maxOn': state.maxOn,
        'max': state._max,
      };
}