import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_test/services/services.dart';
import 'package:weather_test/widgets/select_location_button.dart';
import 'package:weather_test/widgets/time_and_date.dart';
import 'package:weather_test/widgets/weather_container.dart';
import 'package:weather_test/widgets/forecast_list.dart';
import 'package:weather_test/widgets/weather_details.dart';
import 'package:weather_test/widgets/dialogs.dart';

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
      setState(() {
        isLoading = false;
      });
      showErrorDialog(context, "Wrong city, please enter again.");
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
          fit: BoxFit.fill,
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
                      SelectLocationButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                      const SizedBox(height: 50,),
                      TimeAndDate(formattedDate: formattedDate, formattedTime: formattedTime),
                      const SizedBox(height: 30,),
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
                      const SizedBox(height: 20),
                      
                      const SizedBox(height: 50,),
                      if (forecast != null) ForecastList(forecast: forecast!.sublist(1, 7)),
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
