import 'package:flutter/material.dart';

class LocationSearch extends StatelessWidget {
  const LocationSearch({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.near_me_outlined),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              alignment: Alignment.center,
              children: const <Widget>[
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(Icons.search),
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 40),
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
