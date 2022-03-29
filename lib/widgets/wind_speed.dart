import 'package:flutter/material.dart';

class WindSpeed extends StatelessWidget {
  const WindSpeed({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Ветер"),
      color: Colors.teal[100],
    );
  }
}
