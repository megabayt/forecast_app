part of 'date_cubit.dart';

class DateState {
  DateState({
    DateTime? date,
  }) : date = date ?? DateTime.now();

  final DateTime date;
}
