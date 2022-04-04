import 'package:forecast_app/enums/temperature_unit.dart';

double convertToUnit(
    double valueToConvert, TemperatureUnit fromUnit, TemperatureUnit toUnit) {
  if (fromUnit == toUnit) {
    return valueToConvert;
  }
  if (toUnit == TemperatureUnit.celsius) {
    return (valueToConvert - 32) * 5 / 9;
  }
  return (valueToConvert * 9 / 5) + 32;
}
