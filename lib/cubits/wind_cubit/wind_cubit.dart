import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';
import 'package:forecast_app/enums/speed_unit.dart';
import 'package:forecast_app/mixins/with_date.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:meta/meta.dart';

part 'wind_state.dart';

class WindCubit extends HydratedCubit<WindState> with WithDate {
  WindCubit({required DateCubit dateCubit}) : super(WindState()) {
    subDate(dateCubit);
  }

  @override
  close() async {
    await unsubDate();
    super.close();
  }

  onSpeedData(Map<String, dynamic> data) {
    emit(state.copyWith(speedData: data));
  }

  onGustsData(Map<String, dynamic> data) {
    emit(state.copyWith(gustsData: data));
  }

  onDirectionData(Map<String, dynamic> data) {
    emit(state.copyWith(directionData: data));
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
        speedUnit: SpeedUnit.values.elementAt(json['SpeedUnit']),
        gustsOn: json['gustsOn'],
        maxOn: json['maxOn'],
        max: json['max'],
      );

  @override
  Map<String, dynamic> toJson(WindState state) => {
        'SpeedUnit': state.speedUnit.index,
        'gustsOn': state.gustsOn,
        'maxOn': state.maxOn,
        'max': state._max,
      };
}
