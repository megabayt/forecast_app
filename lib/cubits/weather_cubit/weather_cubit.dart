import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class WeatherCubit extends HydratedCubit<int> {
  WeatherCubit() : super(0);

  onValue(int newValue) {
    emit(newValue);
  }

  @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => {'value': state};
}
