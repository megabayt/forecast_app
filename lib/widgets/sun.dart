import 'package:flutter/material.dart';

class Sun extends StatelessWidget {
  const Sun({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Солнце"),
      color: Colors.teal[100],
    );
  }
}
