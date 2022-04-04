part of 'common_bloc.dart';

@immutable
@CopyWith()
class CommonState {
  final bool isFetching;
  final String error;

  const CommonState({
    this.isFetching = false,
    this.error = '',
  });
}
