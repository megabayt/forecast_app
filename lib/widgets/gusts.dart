import 'package:flutter/material.dart';

class Gusts extends StatelessWidget {
  const Gusts({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Порывы"),
      color: Colors.teal[100],
    );
  }
}
