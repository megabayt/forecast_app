import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/blocs/common_bloc/common_bloc.dart';
import 'package:forecast_app/cubits/cloudiness_cubit/cloudiness_cubit.dart';
import 'package:forecast_app/cubits/common_settings_cubit/common_settings_cubit.dart';
import 'package:forecast_app/cubits/precipitation_cubit/precipitation_cubit.dart';
import 'package:forecast_app/cubits/wind_cubit/wind_cubit.dart';
import 'package:forecast_app/cubits/sun_cubit/sun_cubit.dart';
import 'package:forecast_app/cubits/temperature_cubit/temperature_cubit.dart';
import 'package:forecast_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:forecast_app/widgets/conditions.dart';
import 'package:forecast_app/services/service_locator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  await dotenv.load(fileName: ".env");
  setupServiceLocator();
  HydratedBlocOverrides.runZoned(
    () => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => WeatherCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => SunCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => TemperatureCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => WindCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => PrecipitationCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => CloudinessCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => CommonSettingsCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => CommonBloc(
              weatherCubit: BlocProvider.of<WeatherCubit>(context),
              sunCubit: BlocProvider.of<SunCubit>(context),
              temperatureCubit: BlocProvider.of<TemperatureCubit>(context),
              windCubit: BlocProvider.of<WindCubit>(context),
              precipitationCubit: BlocProvider.of<PrecipitationCubit>(context),
              cloudinessCubit: BlocProvider.of<CloudinessCubit>(context),
              commonSettingsCubit:
                  BlocProvider.of<CommonSettingsCubit>(context),
            )..add(FetchAll()),
            lazy: false,
          ),
        ],
        child: const MyApp(),
      ),
    ),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Conditions(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter app Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cloudy_snowing),
            label: 'Условия',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Прогноз',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward),
            label: 'Профиль ветра',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Помощь',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal[100],
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
