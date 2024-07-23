import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_test/services/services.dart';
import 'package:weather_test/widgets/time_and_date.dart';
import '../widgets/weather_container.dart';
import '../widgets/forecast_list.dart';
import '../widgets/weather_details.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherService weatherService = WeatherService();
  Weather? currentWeather;
  List<Weather>? forecast;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cityName = ModalRoute.of(context)!.settings.arguments as String?;
    if (cityName != null) {
      fetchWeather(cityName);
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
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
      // Handle error
      print('Error fetching weather data: $e');
      setState(() {
        isLoading = false;
      });
      // Show error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching weather data: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE, MMMM d').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/scaffoldbackground.jpg'),
          fit: BoxFit.fill
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50,),
                      TimeAndDate(formattedDate: formattedDate, formattedTime: formattedTime),
                      const SizedBox(height: 30,),
                      WeatherContainer(weather: currentWeather!),
                      const SizedBox(height: 50,),
                      if (forecast != null) ForecastList(forecast: forecast!.sublist(0, 5)),
                      const SizedBox(height: 75,),
                      WeatherDetails(weather: currentWeather!),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
