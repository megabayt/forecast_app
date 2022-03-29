import 'package:flutter/material.dart';

class WindDirection extends StatelessWidget {
  const WindDirection({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Направление ветра"),
      color: Colors.teal[100],
    );
  }
}
