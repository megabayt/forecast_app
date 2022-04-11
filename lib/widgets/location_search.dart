import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/location_cubit/location_cubit.dart';

class LocationSearch extends StatefulWidget {
  const LocationSearch({Key? key}) : super(key: key);

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
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

  @override
  build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (locationCubitContext, locationState) {
        if (locationState.loading) {
          _animationController.repeat(reverse: true);
        } else {
          _animationController.reset();
          _animationController.value = 1;
        }
      },
      builder: (locationCubitContext, locationState) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            onTap: () {
              if (locationState.loading) {
                return;
              }
              BlocProvider.of<CommonBloc>(context).add(FetchCurrentLocation());
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
      ),
    );
  }
}
