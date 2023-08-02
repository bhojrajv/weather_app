import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/cubit/location_cubit/locationcubit_cubit.dart';
import 'package:flutter_weather/cubit/theme/theme.dart';
import 'package:flutter_weather/view/splash_screen.dart';
import 'package:weather_repository/weather_repository.dart';

import 'flavours/flavours_configurefile.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({required WeatherRepository weatherRepository, super.key})
      : _weatherRepository = weatherRepository;

  final WeatherRepository _weatherRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit(),),
          BlocProvider(create: (_)=>LocationcubitCubit())
        ],
        child: const WeatherAppView(),
      ),
    );
  }
}

class WeatherAppView extends StatelessWidget {
  const WeatherAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ThemeCubit, Color>(
      builder: (context, color) {
        FlavoursConfig.getInstance()..context =context
        ..color=color;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: FlavoursConfig.getInstance().apptheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
