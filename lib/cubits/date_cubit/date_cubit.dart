import 'package:bloc/bloc.dart';
import 'package:forecast_app/utils/helpers.dart';

part 'date_state.dart';

class DateCubit extends Cubit<DateState> {
  DateCubit() : super(DateState());

  onData({
    int? offsetMinutes,
    int? offsetDays,
  }) {
    emit(state.copyWith(
      offsetMinutes: offsetMinutes,
      offsetDays: offsetDays,
    ));
  }
}
