part of 'cloudiness_cubit.dart';

@immutable
class CloudinessState extends WithDateState {
  CloudinessState({
    DateTime? date,
    this.data = const [],
    this.maxOn = true,
    this.max = 40,
  }) : super(date: (date ?? DateTime.now()));

  @override
  CloudinessState copyWith({
    DateTime? date,
    List<Date>? data,
    bool? maxOn,
    double? max,
    double? value,
  }) =>
      CloudinessState(
        date: date ?? this.date,
        data: data ?? this.data,
        maxOn: maxOn ?? this.maxOn,
        max: max ?? this.max,
      );

  final List<Date> data;
  final bool maxOn;
  final double max;

  double get value {
    return data
        .firstWhereOrNull(
            (element) => element.date.difference(date).inMinutes.abs() < 5)
        ?.value ?? 0;
  }

  get recommended {
    return maxOn && value < max;
  }
}
