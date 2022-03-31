import 'package:flutter/material.dart';
import 'package:forecast_app/widgets/captured_satellites.dart';
import 'package:forecast_app/widgets/cloudiness.dart';
import 'package:forecast_app/widgets/day_picker.dart' as day_picker_widget;
import 'package:forecast_app/widgets/gusts.dart';
import 'package:forecast_app/widgets/kp_index.dart';
import 'package:forecast_app/widgets/location_search.dart';
import 'package:forecast_app/widgets/non_flight_zones.dart';
import 'package:forecast_app/widgets/precipitation.dart';
import 'package:forecast_app/widgets/recommendation.dart';
import 'package:forecast_app/widgets/sun.dart';
import 'package:forecast_app/widgets/temperature.dart';
import 'package:forecast_app/widgets/time_slider.dart';
import 'package:forecast_app/widgets/visible_satellites.dart';
import 'package:forecast_app/widgets/weather.dart';
import 'package:forecast_app/widgets/wind_speed.dart';
import 'package:forecast_app/widgets/wind_direction.dart';
import 'package:forecast_app/widgets/visibility.dart' as visibility_widget;

class Conditions extends StatelessWidget {
  const Conditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const LocationSearch(),
          const Recommendation(),
          const SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: GridView.count(
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 1.65,
              children: const <Widget>[
                Weather(),
                Sun(),
                Temperature(),
                WindSpeed(),
                Gusts(),
                WindDirection(),
                Precipitation(),
                Cloudiness(),
                visibility_widget.Visibility(),
                VisibleSatellites(),
                KpIndex(),
                CapturedSatellites(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const NonFlightZones(),
          const SizedBox(height: 10),
          const TimeSlider(),
          const day_picker_widget.DayPicker(),
        ],
      ),
    );
  }
}
