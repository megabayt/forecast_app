part of 'wind_cubit.dart';

@immutable
class WindState extends WithDateState {
  WindState({
    DateTime? date,
    this.speedData = const {},
    this.gustsData = const {},
    this.directionData = const {},
    this.speedUnit = SpeedUnit.ms,
    this.maxOn = true,
    this.gustsOn = true,
    double max = 30,
  })  : _max = max,
        super(date: (date ?? DateTime.now()));

  @override
  WindState copyWith({
    DateTime? date,
    Map<String, dynamic>? speedData,
    Map<String, dynamic>? gustsData,
    Map<String, dynamic>? directionData,
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
    return directionData[dateUtcString] ?? 0;
  }

  final Map<String, dynamic> speedData;
  final Map<String, dynamic> gustsData;
  final Map<String, dynamic> directionData;
  final SpeedUnit speedUnit;

  double get speed {
    return convertToSpeedUnit(
      speedData[dateUtcString] ?? 0,
      SpeedUnit.ms,
      speedUnit,
    );
  }

  double get gusts {
    return convertToSpeedUnit(
      gustsData[dateUtcString] ?? 0,
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

  bool get recommendedSpeed {
    if (maxOn && speed >= max) {
      return false;
    }
    return true;
  }

  bool get recommendedGusts {
    if (gustsOn && maxOn && gusts >= max) {
      return false;
    }
    return true;
  }
}
