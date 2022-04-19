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
  bool wasFetchingMyLocation = false;

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

  void _handleTextChanged(String text) async {
    if (text.length <= 3) {
      return;
    }
    BlocProvider.of<LocationBloc>(context).add(FetchLocation(address: text));
  }

  @override
  build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (locationBlocContext, locationState) {
        if (locationState.isFetchingMyLocation) {
          _animationController.repeat(reverse: true);
          wasFetchingMyLocation = true;
        } else {
          _animationController.reset();
          _animationController.value = 1;
          if (wasFetchingMyLocation && locationState.myLocation != null) {
            final address = locationState.myLocation?.address;
            if (address != null) {
              final addressString = address.formatted ?? '';

              _textEditingController.value =
                  TextEditingValue(text: addressString);
            }
            wasFetchingMyLocation = false;
          }
        }
      },
      builder: (locationBlocContext, locationState) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            onTap: () {
              if (locationState.isFetchingMyLocation) {
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
                  LayoutBuilder(
                    builder: (context, constraints) => Autocomplete<String>(
                      fieldViewBuilder: (context, textEditingController,
                          focusNode, onFieldSubmitted) {
                        _textEditingController = textEditingController;
                        return TextField(
                          controller: textEditingController,
                          onChanged: _handleTextChanged,
                          onSubmitted: (String value) {
                            onFieldSubmitted();
                          },
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 40),
                            border: OutlineInputBorder(),
                            hintText: 'Enter a search term',
                          ),
                        );
                      },
                      optionsViewBuilder: (context, onSelected, options) =>
                          Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(4.0)),
                          ),
                          child: SizedBox(
                            height: 52.0 * options.length,
                            width:
                                constraints.biggest.width, // <-- Right here !
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: options.length,
                              shrinkWrap: false,
                              itemBuilder: (BuildContext context, int index) {
                                final String option = options.elementAt(index);
                                return InkWell(
                                  onTap: () => onSelected(option),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(option),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      optionsBuilder: (TextEditingValue value) {
                        if (value.text.length <= 3 ||
                            locationState.foundPositions == null ||
                            locationState.isFetchingMyLocation) {
                          return const Iterable<String>.empty();
                        }
                        return locationState.foundPositions!
                            .map(
                              (e) => e.address?.formatted ?? '',
                            )
                            .toList();
                      },
                      onSelected: (String selection) {
                        final location = locationState.foundPositions
                            ?.firstWhere((element) =>
                                element.address?.formatted == selection);
                        if (location != null) {
                          BlocProvider.of<LocationBloc>(context)
                              .add(FetchMyLocationSuccess(data: location));
                        }
                      },
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
