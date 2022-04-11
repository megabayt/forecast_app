import 'package:flutter/material.dart';

class CapturedSatellites extends StatelessWidget {
  const CapturedSatellites({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return const Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text("Пойманные спутники"),
      ),
    );
  }
}
