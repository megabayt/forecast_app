import 'package:flutter/material.dart';

class Visibility extends StatelessWidget {
  const Visibility({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Видимость"),
      color: Colors.teal[100],
    );
  }
}
