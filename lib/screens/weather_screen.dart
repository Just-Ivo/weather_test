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
      _showErrorDialog("Enter city again");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.grey,
                    Colors.grey,
                    Colors.white,
                  ],
                ),
                border: Border.all(
                  color: const Color.fromARGB(0, 76, 34, 34).withOpacity(1),
                  width: 2.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
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
                      SizedBox(height: 50,),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          //   gradient: const LinearGradient(
                          //   colors: [
                          //     Color.fromARGB(255, 0, 0, 0),
                          //     Colors.grey,
                          //     Colors.black,
                              
                          //     Colors.black,
                          //     Colors.black,
                          //     Colors.black,
                              
                          //     Colors.black,
                          //     Colors.grey,
                          //     Color.fromARGB(255, 0, 0, 0),
                          //   ],
                          // ),
                          border: Border.all(
                            color: Colors.white,
                            width: 2.5,
                          ),
                          ),   
                          child: Center(
                            child: const Text(
                              'Select a Location',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 2,
                                
                                
                              ),
                              ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50,),
                      TimeAndDate(formattedDate: formattedDate, formattedTime: formattedTime),
                      const SizedBox(height: 30,),
                      WeatherContainer(
                        weather: currentWeather!,
                        onTap: () {
                          // Handle navigation or other actions
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
