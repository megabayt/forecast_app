import 'package:flutter/material.dart';

class Recommendation extends StatelessWidget {
  const Recommendation({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Text("Не советуем летать"),
      color: Colors.teal[100],
      height: 80,
      width: double.infinity,
    );
  }
}
