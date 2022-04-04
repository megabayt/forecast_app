import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'sun_state.dart';

class SunCubit extends HydratedCubit<SunState> {
  SunCubit() : super(const SunState());

  onValue({String? sunrise, String? sunset}) {
    if (sunrise == null || sunset == null) {
      return;
    }
    final sunriseDate = DateTime.parse(sunrise);
    final sunriseStr =
        '${sunriseDate.hour.toString().padLeft(2, '0')}:${sunriseDate.minute.toString().padLeft(2, '0')}';

    final sunsetDate = DateTime.parse(sunset);
    final sunsetStr =
        '${sunsetDate.hour.toString().padLeft(2, '0')}:${sunsetDate.minute.toString().padLeft(2, '0')}';
    emit(SunState(sunrise: sunriseStr, sunset: sunsetStr));
  }

  @override
  SunState fromJson(Map<String, dynamic> json) => SunState(
        sunrise: json['sunrise'],
        sunset: json['sunset'],
      );

  @override
  Map<String, dynamic> toJson(SunState state) => {
        'sunrise': state.sunrise,
        'sunset': state.sunset,
      };
}
