import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:forecast_app/utils/helpers.dart';

part 'date_state.dart';
part 'date_cubit.g.dart';

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
