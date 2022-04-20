part of 'cloudiness_cubit.dart';

@immutable
class CloudinessState extends WithDateState {
  CloudinessState({
    DateTime? date,
    this.data = const {},
    this.maxOn = true,
    this.max = 40,
  }) : super(date: (date ?? DateTime.now()));

  @override
  CloudinessState copyWith({
    DateTime? date,
    Map<String, dynamic>? data,
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

  final Map<String, dynamic> data;
  final bool maxOn;
  final double max;

  double get value {
    return data[dateUtcString] ?? 0;
  }

  bool get recommended {
    return maxOn && value < max;
  }
}
