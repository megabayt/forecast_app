part of 'kpindex_cubit.dart';

@immutable
@CopyWith()
class KpIndexState {
  const KpIndexState({
    this.data = const {},
    this.maxOn = true,
    this.max = 5,
  });

  final Map<String, dynamic> data;
  final bool maxOn;
  final int max;
}
