import 'package:flutter/material.dart';

class KpIndex extends StatelessWidget {
  const KpIndex({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Kp-индекс"),
      color: Colors.teal[100],
    );
  }
}
