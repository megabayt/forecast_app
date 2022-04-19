part of 'kpindex_cubit.dart';

@immutable
class KpIndexState extends WithDateState {
  KpIndexState({
    DateTime? date,
    this.data = const [],
    this.maxOn = true,
    this.max = 5,
  }) : super(date: (date ?? DateTime.now()));

  @override
  KpIndexState copyWith({
    DateTime? date,
    List<Date>? data,
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

  final List<Date> data;
  final bool maxOn;
  final int max;

  int get value {
    return data
        .firstWhereOrNull(
            (element) => element.date.difference(date).inMinutes.abs() < 5)
        ?.value ?? 0;
  }

  get recommended {
    return maxOn && value < max;
  }
}
