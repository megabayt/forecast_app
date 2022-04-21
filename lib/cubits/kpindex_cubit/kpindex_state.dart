part of 'kpindex_cubit.dart';

@immutable
class KpIndexState extends WithDateState {
  KpIndexState({
    DateTime? date,
    this.data = const {},
    this.maxOn = true,
    this.max = 5,
  }) : super(date: date);

  @override
  KpIndexState copyWith({
    DateTime? date,
    Map<String, dynamic>? data,
    bool? maxOn,
    int? max,
    int? value,
  }) =>
      KpIndexState(
        date: date ?? this.date,
        data: data ?? this.data,
        maxOn: maxOn ?? this.maxOn,
        max: max ?? this.max,
      );

  final Map<String, dynamic> data;
  final bool maxOn;
  final int max;

  int get value {
    return getValueByDate(date);
  }

  int getValueByDate(DateTime date) {
    return data[roundToNearest5String(date)] ?? 0;
  }

  bool get recommended {
    return getRecommendedByDate(date);
  }

  bool getRecommendedByDate(DateTime date) {
    return !maxOn || getValueByDate(date) < max;
  }

  bool getRecommendedByDateRange(DateTime date1, DateTime date2) {
    int sum = 0;
    int count = 0;
    for (DateTime date = date1;
        date.isBefore(date2);
        date = date.add(const Duration(minutes: 5))) {
      sum += getRecommendedByDate(date) ? 1 : 0;
      count++;
    }

    return sum / count > 0.5;
  }
}
