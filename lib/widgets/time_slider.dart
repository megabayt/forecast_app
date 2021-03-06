import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';
import 'package:forecast_app/mixins/cloudiness_mixin.dart';
import 'package:forecast_app/mixins/common_settings_mixin.dart';
import 'package:forecast_app/mixins/date_mixin.dart';
import 'package:forecast_app/mixins/kpindex_mixin.dart';
import 'package:forecast_app/mixins/precipitation_mixin.dart';
import 'package:forecast_app/mixins/recommended.dart';
import 'package:forecast_app/mixins/temperature_mixin.dart';
import 'package:forecast_app/mixins/visibility_mixin.dart';
import 'package:forecast_app/mixins/wind_mixin.dart';
import 'package:forecast_app/utils/helpers.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TimeSlider extends StatelessWidget
    with
        DateMixin,
        CommonSettingsMixin,
        TemperatureMixin,
        WindMixin,
        PrecipitationMixin,
        CloudinessMixin,
        KpIndexMixin,
        VisibilityMixin,
        RecommendedMixin {
  const TimeSlider({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return buildRecommended(builder:
        (bool Function(DateTime date1, [DateTime? date2]) getRecommended) {
      return BlocBuilder<DateCubit, DateState>(
          builder: (dateContext, dateState) {
        final now = dateState.now;
        final date = now.add(Duration(
            days: dateState.offsetDays, minutes: dateState.offsetMinutes));
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: List.generate(288, (index) {
                      return index / 288;
                    }),
                    colors: List.generate(288, (index) {
                      final base = dateState.now.add(Duration(
                        days: dateState.offsetDays,
                      ));
                      final date =
                          convertHourToDateTime(index * 24 / 288, base);
                      final recommended = getRecommended(date);

                      return recommended
                          ? Colors.green.shade300
                          : Colors.red.shade300;
                    }),
                  ),
                )),
            SfSliderTheme(
              data: SfSliderThemeData(
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                thumbColor: Colors.white,
                overlayRadius: 0,
                thumbRadius: 0,
              ),
              child: SfSlider(
                min: 0.0,
                max: 24.0,
                value: date.hour + date.minute / 60,
                interval: 3,
                showTicks: true,
                minorTicksPerInterval: 1,
                tickShape: _SfTickShape(),
                minorTickShape: _SfMinorTickShape(),
                thumbShape: _SfThumbShape(),
                onChanged: (dynamic value) {
                  // more than 23:55
                  if (value > 23.92) {
                    return;
                  }
                  final dateByValue = convertHourToDateTime(value);
                  final diff = dateByValue.difference(now);
                  BlocProvider.of<DateCubit>(context).onData(
                    offsetMinutes: diff.inMinutes,
                  );
                },
              ),
            ),
          ],
        );
      });
    });
  }
}

class _SfTickShape extends SfTickShape {
  var i = -1;

  @override
  void paint(PaintingContext context, Offset offset, Offset? thumbCenter,
      Offset? startThumbCenter, Offset? endThumbCenter,
      {required RenderBox parentBox,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Animation<double> enableAnimation,
      required TextDirection textDirection}) {
    i++;

    final text = i == 0 || i * 3 == 24 ? '' : (i * 3).toString();

    if (i * 3 == 24) {
      i = -1;
    }

    if (text == '') {
      return;
    }

    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 2
      ..color = Colors.white;
    context.canvas.drawLine(
      Offset(offset.dx, offset.dy + 3),
      Offset(offset.dx, offset.dy + 13),
      paint,
    );

    var textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 12,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(minWidth: 0, maxWidth: 50);
    final textOffset =
        Offset(offset.dx - textPainter.width / 2, offset.dy - 14);
    textPainter.paint(context.canvas, textOffset);
  }
}

class _SfThumbShape extends SfThumbShape {
  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required RenderBox? child,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required SfThumb? thumb}) {
    Size thumbSize = const Size(2, 30);
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    context.canvas.drawLine(
      Offset(center.dx, center.dy - thumbSize.height / 2),
      Offset(center.dx, center.dy + thumbSize.height / 2),
      paint,
    );
  }
}

class _SfMinorTickShape extends SfTickShape {
  @override
  void paint(PaintingContext context, Offset offset, Offset? thumbCenter,
      Offset? startThumbCenter, Offset? endThumbCenter,
      {required RenderBox parentBox,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Animation<double> enableAnimation,
      required TextDirection textDirection}) {}
}
