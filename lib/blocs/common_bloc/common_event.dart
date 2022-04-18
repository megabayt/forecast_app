part of 'common_bloc.dart';

@immutable
abstract class CommonEvent {}

class FetchAll extends CommonEvent {
  FetchAll({required this.position});

  final Position position;
}
