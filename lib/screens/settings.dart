import 'package:flutter/material.dart';
import 'package:forecast_app/screens/threshold_settings.dart';
import 'package:forecast_app/screens/unit_settings.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('Настройки пороговых параметров'),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) {
                return const ThresholdSettings();
              },
            );
          },
        ),
        ListTile(
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('Настройки единиц измерения'),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) {
                return const UnitSettings();
              },
            );
          },
        ),
      ],
    );
  }
}
