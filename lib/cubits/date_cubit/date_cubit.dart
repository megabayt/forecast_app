import 'package:bloc/bloc.dart';
import 'package:forecast_app/utils/helpers.dart';

part 'date_state.dart';

class DateCubit extends Cubit<DateState> {
  DateCubit() : super(DateState());

  onData({
    required int offsetMinutes,
    required int offsetDays,
  }) {
    emit(state.copyWith(
      offsetMinutes: offsetMinutes,
      offsetDays: offsetDays,
    ));
  }
}
