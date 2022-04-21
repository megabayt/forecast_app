part of 'date_cubit.dart';

class DateState {
  DateState({
    this.offsetMinutes = 0,
    this.offsetDays = 0,
  });

  DateState copyWith({
    int? offsetMinutes,
    int? offsetDays,
  }) {
    final copy = DateState(
      offsetMinutes: offsetMinutes ?? this.offsetMinutes,
      offsetDays: offsetDays ?? this.offsetDays,
    );
    copy._now = _now;
    return copy;
  }

  var _now = roundToNearest5(DateTime.now());
  DateTime get now {
    return _now;
  }

  final int offsetMinutes;
  final int offsetDays;
}
