import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class DayPicker extends StatefulWidget {
  const DayPicker({Key? key}) : super(key: key);

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  final days = ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'];
  var _currentDayIndex = 0;

  @override
  build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: days.mapIndexed((index, text) {
          return _DayBtn(
              text: text,
              selected: index == _currentDayIndex,
              onPressed: () {
                setState(() {
                  _currentDayIndex = index;
                });
              });
        }).toList(),
      ),
    );
  }
}

class _DayBtn extends StatelessWidget {
  const _DayBtn({
    required this.text,
    required this.selected,
    required this.onPressed,
  });

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
            color: Colors.red,
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
