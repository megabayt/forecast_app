import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'common_settings_state.dart';

class CommonSettingsCubit extends HydratedCubit<CommonSettingsState> {
  CommonSettingsCubit() : super(const CommonSettingsState());

  onChangeDistanceUnit(DistanceUnit newUnit) {
    emit(state.copyWith(
      distanceUnit: newUnit,
    ));
  }

  onChangeHeight(double newHeight) {
    emit(state.copyWith(
      height: newHeight,
    ));
  }

  @override
  CommonSettingsState fromJson(Map<String, dynamic> json) =>
      CommonSettingsState(
        distanceUnit: DistanceUnit.values.elementAt(json['distanceUnit']),
        height: json['height'],
      );

  @override
  Map<String, dynamic> toJson(CommonSettingsState state) => {
        'distanceUnit': state.distanceUnit.index,
        'height': state._height,
      };
}
