part of 'kpindex_cubit.dart';

@immutable
class KpIndexState {
  const KpIndexState({
    this.maxOn = true,
    this.max = 5,
    this.value = 0,
  });

  KpIndexState copyWith({
    bool? maxOn,
    int? max,
    int? value,
  }) =>
      KpIndexState(
        maxOn: maxOn ?? this.maxOn,
        max: max ?? this.max,
        value: value ?? this.value,
      );

  final bool maxOn;
  final int max;
  final int value;

  get recommended {
    return maxOn && value < max;
  }
}
