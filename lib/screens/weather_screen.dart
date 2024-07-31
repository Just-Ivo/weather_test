import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_test/services/services.dart';
import 'package:weather_test/widgets/dialogs.dart';
import 'package:weather_test/widgets/style_widgets/select_location_button.dart';
import 'package:weather_test/widgets/time_and_date.dart';
import 'package:weather_test/widgets/weather_container.dart';
import 'package:weather_test/widgets/forecast_list.dart';
import 'package:weather_test/widgets/weather_details.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with SingleTickerProviderStateMixin {
  WeatherService weatherService = WeatherService();
  Weather? currentWeather;
  List<Weather>? forecast;
  bool isLoading = true;

  late AnimationController _animationController;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cityName = ModalRoute.of(context)!.settings.arguments as String?;
    if (cityName != null) {
      fetchWeather(cityName);
    } else {
      setState(() {
        isLoading = false;
      });
    }

    // Move MediaQuery-dependent code here
    final screenWidth = MediaQuery.of(context).size.width;
    _animation1 = Tween<double>(begin: -200, end: screenWidth)
        .animate(_animationController);
    _animation2 = Tween<double>(begin: screenWidth, end: -200)
        .animate(_animationController);
  }

  void fetchWeather(String cityName) async {
    try {
      final weather = await weatherService.getCurrentWeather(cityName);
      final forecastData = await weatherService.getWeatherForecast(cityName);
      setState(() {
        currentWeather = weather;
        forecast = forecastData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showErrorDialog(context, "Wrong city, please enter again.");
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE, MMMM d').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/scaffoldbackground.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Moving cloud 1
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                left: _animation1.value,
                top: 100,
                child: Opacity(
                  opacity: 0.5, // transparency
                  child: Image.asset(
                    'assets/cloud_transparent.png',
                    width: 200,
                  ),
                ),
              );
            },
          ),
          // Moving cloud 2
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                left: _animation2.value,
                top: 250,
                child: Opacity(
                  opacity: 0.5, // transparency
                  child: Image.asset(
                    'assets/cloud_transparent.png',
                    width: 300,
                    height: 200,
                  ),
                ),
              );
            },
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          SelectLocationButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                          ),
                          const SizedBox(height: 50),
                          TimeAndDate(
                              formattedDate: formattedDate,
                              formattedTime: formattedTime),
                          const SizedBox(height: 30),
                          WeatherContainer(
                            weather: currentWeather!,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/weather',
                                arguments: currentWeather!.areaName,
                              );
                            },
                          ),
                          const SizedBox(height: 50),
                          if (forecast != null)
                            ForecastList(forecast: forecast!.sublist(1, 7)),
                          const SizedBox(height: 75),
                          WeatherDetails(weather: currentWeather!),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
