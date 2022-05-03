part of 'date_cubit.dart';

@CopyWith()
class DateState {
  DateState({
    this.offsetMinutes = 0,
    this.offsetDays = 0,
  });

  final _now = roundToNearest5(DateTime.now());
  DateTime get now {
    return _now;
  }

  final int offsetMinutes;
  final int offsetDays;
}
