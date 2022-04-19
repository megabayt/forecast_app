part of 'common_bloc.dart';

@immutable
abstract class CommonEvent {}

class FetchAll extends CommonEvent {
  FetchAll({required this.point});

  final Point point;
}
