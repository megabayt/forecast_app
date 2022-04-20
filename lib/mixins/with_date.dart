import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';
import 'package:forecast_app/utils/helpers.dart';

mixin WithDate<T extends WithDateState> on Cubit<T> {
  StreamSubscription<DateState>? _sub;

  void subDate(DateCubit dateCubit) {
    _sub = dateCubit.stream.listen((event) {
      emit(state.copyWith(
        date: event.date,
      ) as T);
    });
  }

  Future<void> unsubDate() async {
    if (_sub != null) {
      await _sub!.cancel();
    }
  }
}

abstract class WithDateState {
  WithDateState({DateTime? date})
      : date = date ?? roundToNearest5(DateTime.now());

  final DateTime date;

  WithDateState copyWith({
    DateTime date,
  });
}
