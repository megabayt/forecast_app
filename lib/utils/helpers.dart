import 'package:forecast_app/enums/distance_unit.dart';
import 'package:forecast_app/enums/temperature_unit.dart';

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
