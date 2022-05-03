import 'package:flutter/material.dart';
import 'package:forecast_app/mixins/cloudiness_mixin.dart';
import 'package:forecast_app/mixins/common_settings_mixin.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/mixins/kpindex_mixin.dart';
import 'package:forecast_app/mixins/precipitation_mixin.dart';
import 'package:forecast_app/mixins/temperature_mixin.dart';
import 'package:forecast_app/mixins/visibility_mixin.dart';
import 'package:forecast_app/mixins/wind_mixin.dart';

class Recommendation extends StatelessWidget
    with
        DateMixin,
        CommonSettingsMixin,
        TemperatureMixin,
        WindMixin,
        PrecipitationMixin,
        CloudinessMixin,
        KpIndexMixin,
        VisibilityMixin {
  const Recommendation({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return buildTemperature(
      builder: (recommendedTemperature, temperature, temperatureUnit) {
        return buildWind(
          builder: ({
            required direction,
            required distanceUnit,
            required gusts,
            required height,
            required recommendedGusts,
            required recommendedSpeed,
            required speed,
            required speedUnit,
          }) {
            return buildPrecipitation(
              builder: (recommendedPrecipitation, precipitation) {
                return buildCloudiness(
                  builder: (recommendedCloudiness, cloudiness) {
                    return buildKpIndex(
                      builder: (recommendedKpIndex, kpIndex) {
                        return buildVisibility(
                          builder: (recommendedVisibility, visibility, distanceUnit) {
                            final recommended = recommendedTemperature &&
                                recommendedGusts &&
                                recommendedSpeed &&
                                recommendedPrecipitation &&
                                recommendedCloudiness &&
                                recommendedKpIndex &&
                                recommendedVisibility;

                            return Card(
                              elevation: 2,
                              color:
                                  recommended ? Colors.white : Colors.red[300],
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Text(
                                        recommended
                                            ? "Можно летать"
                                            : "Не советуем летать",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(width: 8),
                                      recommended
                                          ? const Icon(
                                              Icons.check_box,
                                              color: Colors.lightGreen,
                                            )
                                          : const Icon(
                                              Icons.warning,
                                              color: Colors.amber,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
