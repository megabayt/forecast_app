import 'package:flutter/material.dart';

class CapturedSatellites extends StatelessWidget {
  const CapturedSatellites({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Пойманные спутники"),
      color: Colors.teal[100],
    );
  }
}
