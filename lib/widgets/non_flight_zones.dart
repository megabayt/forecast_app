import 'package:flutter/material.dart';

class NonFlightZones extends StatelessWidget {
  const NonFlightZones({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(Icons.warning),
        Text(
          "3 NFZ рядом",
          style: TextStyle(color: Colors.redAccent),
        ),
      ],
    );
  }
}
