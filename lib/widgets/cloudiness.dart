import 'package:flutter/material.dart';

class Cloudiness extends StatelessWidget {
  const Cloudiness({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Облачность"),
      color: Colors.teal[100],
    );
  }
}
