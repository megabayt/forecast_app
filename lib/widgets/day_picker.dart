import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';
import 'package:forecast_app/mixins/recommended.dart';

class DayPicker extends StatelessWidget with RecommendedMixin {
  const DayPicker({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return buildRecommended(builder:
        (bool Function(DateTime date1, [DateTime? date2]) getRecommended) {
      return BlocBuilder<DateCubit, DateState>(
          builder: (dateContext, dateState) {
        return SizedBox(
          width: double.infinity,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: days.mapIndexed((index, text) {
              final now = dateState.now;
              final date = now.add(Duration(
                  days: dateState.offsetDays,
                  minutes: dateState.offsetMinutes));
              final weekDayIndex = date.weekday - 1;
              final diff = now.weekday - 1 - index;

              var date1 = now.add(Duration(days: diff > 0 ? 7 - diff : -diff));
              date1 = DateTime(date1.year, date1.month, date1.day);
              final date2 = date1.add(const Duration(days: 1));
              return _DayBtn(
                  recommended: getRecommended(date1, date2),
                  text: text,
                  selected: weekDayIndex == index,
                  onPressed: () {
                    var offsetDays = 0;
                    if (diff > 0) {
                      offsetDays = 7 - diff;
                    } else {
                      offsetDays = -diff;
                    }
                    BlocProvider.of<DateCubit>(context)
                        .onData(offsetDays: offsetDays);
                  });
            }).toList(),
          ),
        );
      });
    });
  }
}

const days = ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'];

class _DayBtn extends StatelessWidget {
  const _DayBtn({
    required this.recommended,
    required this.text,
    required this.selected,
    required this.onPressed,
  });

  final bool recommended;
  final String text;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: selected ? 2 : 1,
            ),
            color: recommended ? Colors.green.shade300 : Colors.red.shade300,
          ),
          padding: const EdgeInsets.all(0),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
