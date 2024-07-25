import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_test/services/services.dart';
import 'package:weather_test/widgets/submit_button.dart';

class LocationSelectorScreen extends StatefulWidget {
  LocationSelectorScreen({super.key});

  @override
  State<LocationSelectorScreen> createState() => _LocationSelectorScreenState();
}

class _LocationSelectorScreenState extends State<LocationSelectorScreen> {
  final TextEditingController _controller = TextEditingController();
  final WeatherService weatherService = WeatherService();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> submitHandler() async {
    try {
      _validateInput(_controller.text);
      await _fetchWeatherData(_controller.text);
      Navigator.pushNamed(
        context,
        '/weather',
        arguments: _controller.text,
      );
    } catch (e) {
      _showErrorDialog("Enter city again");
    }
  }

  void _validateInput(String value) {
    if (value.trim().isEmpty) {
      throw Exception('Please enter a location');
    }
  }

  Future<void> _fetchWeatherData(String cityName) async {
    try {
      await weatherService.getCurrentWeather(cityName);
      await weatherService.getWeatherForecast(cityName);
    } catch (e) {
      throw Exception('City not found');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid city name'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey,
          child: const Text(
            'Location Selector',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 18, 0, 134),
                Color.fromARGB(255, 12, 146, 203),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Text(
                'Select your location',
                style: GoogleFonts.playfairDisplay(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Type out your address',
                style: GoogleFonts.playfairDisplay(
                  textStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _controller,
                cursorColor: Colors.white,
                style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_city,
                    color: Colors.white,
                  ),
                  label: Text('Location name'),
                  iconColor: Colors.white,
                  filled: false,
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              SubmitButton(
                onPressed: submitHandler,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
