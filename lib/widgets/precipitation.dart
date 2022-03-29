import 'package:flutter/material.dart';

class Precipitation extends StatelessWidget {
  const Precipitation({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Вероятность осадков"),
      color: Colors.teal[100],
    );
  }
}
