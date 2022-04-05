import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/enums/temperature_unit.dart';
import 'package:forecast_app/enums/speed_unit.dart';

double convertToTemperatureUnit(
    double valueToConvert, TemperatureUnit fromUnit, TemperatureUnit toUnit) {
  if (fromUnit == toUnit) {
    return valueToConvert;
  }
  if (toUnit == TemperatureUnit.celsius) {
    return (valueToConvert - 32) * 5 / 9;
  }
  return (valueToConvert * 9 / 5) + 32;
}

double convertToDistanceUnit(
    double valueToConvert, DistanceUnit fromUnit, DistanceUnit toUnit) {
  if (fromUnit == toUnit) {
    return valueToConvert;
  }
  if (toUnit == DistanceUnit.feet) {
    return valueToConvert * 3.28084;
  }
  return valueToConvert / 3.28084;
}

final speedConverters = {
  SpeedUnit.kmh: {
    SpeedUnit.mph: (double valueToConvert) => valueToConvert / 1.609,
    SpeedUnit.knots: (double valueToConvert) => valueToConvert / 1.852,
    SpeedUnit.ms: (double valueToConvert) => valueToConvert / 3.6,
  },
  SpeedUnit.mph: {
    SpeedUnit.kmh: (double valueToConvert) => valueToConvert * 1.609,
    SpeedUnit.knots: (double valueToConvert) => valueToConvert / 1.151,
    SpeedUnit.ms: (double valueToConvert) => valueToConvert / 2.237,
  },
  SpeedUnit.knots: {
    SpeedUnit.kmh: (double valueToConvert) => valueToConvert * 1.852,
    SpeedUnit.mph: (double valueToConvert) => valueToConvert * 1.151,
    SpeedUnit.ms: (double valueToConvert) => valueToConvert / 1.944,
  },
  SpeedUnit.ms: {
    SpeedUnit.kmh: (double valueToConvert) => valueToConvert * 3.6,
    SpeedUnit.mph: (double valueToConvert) => valueToConvert * 2.237,
    SpeedUnit.knots: (double valueToConvert) => valueToConvert * 1.944,
  },
};
double convertToSpeedUnit(
    double valueToConvert, SpeedUnit fromUnit, SpeedUnit toUnit) {
  if (fromUnit == toUnit) {
    return valueToConvert;
  }

  final fromConverters = speedConverters[fromUnit];

  if (fromConverters == null) {
    throw Exception("no compatible converter");
  }

  final converter = fromConverters[toUnit];

  if (converter == null) {
    throw Exception("no compatible converter");
  }

  return converter(valueToConvert);
}

const bftRanges = {
  0: 0,
  5: 1,
  11: 2,
  19: 3,
  28: 4,
  38: 5,
  49: 6,
  61: 7,
  74: 8,
  88: 9,
  102: 10,
  117: 11,
};
int getBftValue(double valueToConvert, SpeedUnit fromUnit) {
  final kmh = convertToSpeedUnit(valueToConvert, fromUnit, SpeedUnit.ms);
  final key = bftRanges.keys.firstWhere((element) => kmh < element);

  return bftRanges[key] ?? 12;
}

const speedUnitLabels = {
  SpeedUnit.kmh: 'км/ч',
  SpeedUnit.ms: 'м/с',
  SpeedUnit.mph: 'mph',
  SpeedUnit.knots: 'узлов',
  SpeedUnit.bft: '',
};
String getSpeedUnitLabel(SpeedUnit speedUnit) {
  return speedUnitLabels[speedUnit] ?? '';
}
