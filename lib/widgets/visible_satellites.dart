import 'package:flutter/material.dart';

class VisibleSatellites extends StatelessWidget {
  const VisibleSatellites({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return const Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text("Видимые спутники"),
      ),
    );
  }
}
