import 'package:bloc/bloc.dart';

part 'date_state.dart';

class DateCubit extends Cubit<DateState> {
  DateCubit() : super(DateState());

  onDate(DateTime newDate) {
    emit(DateState(date: newDate));
  }
}
