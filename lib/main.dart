import 'package:flutter/material.dart';
import 'screens/weather_screen.dart';
import 'screens/location_selector_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
    const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weatherinho',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LocationSelectorScreen(),
        '/weather': (context) => const WeatherScreen(),
      },
    );
  }
}
