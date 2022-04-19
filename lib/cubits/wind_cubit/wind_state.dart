part of 'wind_cubit.dart';

@immutable
class WindState extends WithDateState {
  WindState({
    DateTime? date,
    this.speedData = const [],
    this.gustsData = const [],
    this.directionData = const [],
    this.speedUnit = SpeedUnit.ms,
    this.maxOn = true,
    this.gustsOn = true,
    double max = 30,
  })  : _max = max,
        super(date: (date ?? DateTime.now()));

  @override
  WindState copyWith({
    DateTime? date,
    List<Date>? speedData,
    List<Date>? gustsData,
    List<Date>? directionData,
    SpeedUnit? speedUnit,
    bool? maxOn,
    bool? gustsOn,
    double? max,
  }) =>
      WindState(
        date: date ?? this.date,
        speedData: speedData ?? this.speedData,
        gustsData: gustsData ?? this.gustsData,
        directionData: directionData ?? this.directionData,
        speedUnit: speedUnit ?? this.speedUnit,
        maxOn: maxOn ?? this.maxOn,
        gustsOn: gustsOn ?? this.gustsOn,
        max: max != null
            ? convertToSpeedUnit(max, this.speedUnit, SpeedUnit.ms)
            : _max,
      );

  double get direction {
    return directionData
        .firstWhereOrNull(
            (element) => element.date.difference(date).inMinutes.abs() < 5)
        ?.value ?? 0;
  }

  final List<Date> speedData;
  final List<Date> gustsData;
  final List<Date> directionData;
  final SpeedUnit speedUnit;

  double get speed {
    return convertToSpeedUnit(
      speedData
          .firstWhereOrNull(
              (element) => element.date.difference(date).inMinutes.abs() < 5)
          ?.value ?? 0,
      SpeedUnit.ms,
      speedUnit,
    );
  }

  double get gusts {
    return convertToSpeedUnit(
      gustsData
          .firstWhereOrNull(
              (element) => element.date.difference(date).inMinutes.abs() < 5)
          ?.value ?? 0,
      SpeedUnit.ms,
      speedUnit,
    );
  }

  final bool gustsOn;
  final bool maxOn;
  final double _max;
  double get max {
    return convertToSpeedUnit(_max, SpeedUnit.ms, speedUnit).floorToDouble();
  }

  get recommendedSpeed {
    if (maxOn && speed >= max) {
      return false;
    }
    return true;
  }

  get recommendedGusts {
    if (gustsOn && maxOn && gusts >= max) {
      return false;
    }
    return true;
  }
}
