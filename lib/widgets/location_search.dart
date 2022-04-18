import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/location_bloc/location_bloc.dart';

class LocationSearch extends StatefulWidget {
  const LocationSearch({Key? key}) : super(key: key);

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      value: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTextChanged(String text) async {
    if (text.length <= 3) {
      return;
    }
  }

  @override
  build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (locationBlocContext, locationState) {
        if (locationState.isFetching) {
          _animationController.repeat(reverse: true);
        } else {
          _animationController.reset();
          _animationController.value = 1;
        }
        if (locationState.myLocation != null) {
          final address = locationState.myLocation?.address;
          if (address != null) {
            final addressString = address.formatted ?? '';

            _textEditingController.value =
                TextEditingValue(text: addressString);
          }
        }
      },
      builder: (locationBlocContext, locationState) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            onTap: () {
              if (locationState.isFetching) {
                return;
              }
              BlocProvider.of<LocationBloc>(context).add(FetchMyLocation());
            },
            child: FadeTransition(
              opacity: _animationController,
              child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.near_me_outlined)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  const Positioned.fill(
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
                    controller: _textEditingController,
                    onChanged: _handleTextChanged,
                    decoration: const InputDecoration(
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
      ),
    );
  }
}
