import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/cubit/weather/view/weather_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    // TODO: implement initState
    startAnimation();
    super.initState();
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() { animate = true; });
    await Future.delayed(const Duration(milliseconds: 5000));
    Navigator.push(context, MaterialPageRoute(builder: (context)=> WeatherPage()));
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return  Scaffold(
      body:  Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: animate ? 0 : 30,
            left: animate ? 0 : 30,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: animate ? 1 : 0,
              child: const Image(image: AssetImage('assets/wlogo.jpg'), width: 40,height: 40,),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 2000),
            top: size.height/3.5,
            left: animate ? 30 : -80,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              opacity: animate ? 1 : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome To",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    "Weather app",
                    style: Theme.of(context).textTheme.headline2,
                  )
                ],
              ),
            ),
          ),
          AnimatedPositioned(
               left: size.width/5.5,
            duration: const Duration(milliseconds: 2400),
            bottom: animate ? 100 : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              opacity: animate ? 1 : 0,
              child:  Image(image: AssetImage("assets/weatherlogo.png"),width: size.width,height: size.height/4,),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 2400),
            bottom: animate ? 60 : 0,
            right: 30,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              opacity: animate ? 1 : 0,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
