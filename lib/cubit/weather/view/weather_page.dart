import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/cubit/location_cubit/locationcubit_cubit.dart';
import 'package:flutter_weather/cubit/theme/theme.dart';
import 'package:flutter_weather/cubit/weather/cubit/weather_cubit.dart';
import 'package:flutter_weather/cubit/weather/weather.dart';
import 'package:flutter_weather/cubit/weather/widgets/weather_empty.dart';
import 'package:flutter_weather/flavours/flavours_configurefile.dart';
import 'package:weather_repository/weather_repository.dart';

import '../../../view/search/search.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  late String city;
  @override
  void initState() {
    city="";
    context.read<LocationcubitCubit>().getAddress();
    // TODO: implement initState
    context.read<LocationcubitCubit>().emit(LocationLoaded());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<LocationcubitCubit, LocationcubitState>(
          builder: (context, state) {
           // debugPrint("state::::${state}");
            if(state is LocationLoaded){
             // debugPrint("latlng::${state.long}/${state.lat}");
              if(city==null||city==""){
                 context.read<WeatherCubit>().fetchCurrentweather(lat: state.lat??0.0, long: state.long??0.0
                 ,name: state.address?.first.subLocality??"");
              }
              return Text('${state.address?.first.subLocality??""}');
            }
            return Text('Flutter Weather');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0,top: 15),
            child: Text("${FlavoursConfig.getInstance().apptitle}",
             textAlign: TextAlign.center,),
          )
           /*IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push<void>(
                SettingsPage.route(
                  context.read<WeatherCubit>(),
                ),
              );
            },
          ),*/
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<ThemeCubit>().updateTheme(state.weather);
            }
          },
          builder: (context, state) {
            debugPrint('state:${state.status}');
            switch (state.status) {
              case WeatherStatus.initial:
                return const WeatherEmpty();
              case WeatherStatus.loading:
                return const WeatherLoading();
              case WeatherStatus.success:
                return WeatherPopulated(
                  weather: state.weather,
                  units: state.temperatureUnits,
                  onRefresh: () {
                    return context.read<WeatherCubit>().refreshWeather();
                  },
                );
              case WeatherStatus.failure:
                return const WeatherError();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () async {
           city = await Navigator.of(context).push(SearchPage.route())??"";
          debugPrint("city:$city");
          if (!mounted) return;
          await context.read<WeatherCubit>().fetchWeather(city);
        },
      ),
    );
  }
}
