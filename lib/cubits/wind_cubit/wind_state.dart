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
        super(date: date);

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

  final Map<String, dynamic> speedData;
  final Map<String, dynamic> gustsData;
  final Map<String, dynamic> directionData;
  final SpeedUnit speedUnit;

  final bool gustsOn;
  final bool maxOn;
  final double _max;
  double get max {
    return convertToSpeedUnit(_max, SpeedUnit.ms, speedUnit).floorToDouble();
  }

  double get direction {
    return getDirectionByDate(date);
  }

  double getDirectionByDate(DateTime date) {
    return directionData[roundToNearest5String(date)] ?? 0;
  }

  double get speed {
    return getSpeedByDate(date);
  }

  double getSpeedByDate(DateTime date) {
    return convertToSpeedUnit(
      speedData[roundToNearest5String(date)] ?? 0,
      SpeedUnit.ms,
      speedUnit,
    );
  }

  double get gusts {
    return getGustsByDate(date);
  }

  double getGustsByDate(DateTime date) {
    return convertToSpeedUnit(
      gustsData[roundToNearest5String(date)] ?? 0,
      SpeedUnit.ms,
      speedUnit,
    );
  }

  bool get recommendedSpeed {
    return getRecommendedSpeedByDate(date);
  }

  bool getRecommendedSpeedByDate(DateTime date) {
    if (maxOn && getSpeedByDate(date) >= max) {
      return false;
    }
    return true;
  }

  bool getRecommendedSpeedByDateRange(DateTime date1, DateTime date2) {
    int sum = 0;
    int count = 0;
    for (DateTime date = date1;
        date.isBefore(date2);
        date = date.add(const Duration(minutes: 5))) {
      sum += getRecommendedSpeedByDate(date) ? 1 : 0;
      count++;
    }

    return sum / count > 0.5;
  }

  bool get recommendedGusts {
    return getRecommendedGustsByDate(date);
  }

  bool getRecommendedGustsByDate(DateTime date) {
    if (gustsOn && maxOn && getGustsByDate(date) >= max) {
      return false;
    }
    return true;
  }

  bool getRecommendedGustsByDateRange(DateTime date1, DateTime date2) {
    int sum = 0;
    int count = 0;
    for (DateTime date = date1;
        date.isBefore(date2);
        date = date.add(const Duration(minutes: 5))) {
      sum += getRecommendedGustsByDate(date) ? 1 : 0;
      count++;
    }

    return sum / count > 0.5;
  }
}
