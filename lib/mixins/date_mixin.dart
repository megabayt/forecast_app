import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/cubits/date_cubit/date_cubit.dart';

mixin DateMixin {
  Widget buildDate({required Widget Function(DateTime date) builder}) {
    return BlocBuilder<DateCubit, DateState>(
        builder: (dateContext, dateCubitState) {
      return builder(
        dateCubitState.now.add(
          Duration(
            days: dateCubitState.offsetDays,
            minutes: dateCubitState.offsetMinutes,
          ),
        ),
      );
    });
  }
}
