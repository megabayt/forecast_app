import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:meta/meta.dart';

part 'sun_state.dart';

class SunCubit extends Cubit<SunState> {
  SunCubit() : super(const SunState());

  onData({
    required Map<String, dynamic> sunrise,
    required Map<String, dynamic> sunset,
  }) {
    emit(SunState(sunrises: sunrise, sunsets: sunset));
  }
}
