import 'package:flutter/material.dart';

class VisibleSatellites extends StatelessWidget {
  const VisibleSatellites({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Видимые спутники"),
      color: Colors.teal[100],
    );
  }
}
