import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather/weather.dart';
import 'package:weather_test/services/services.dart';
import 'package:weather_test/widgets/style_widgets/submit_button.dart';
import 'package:weather_test/widgets/style_widgets/textfield.dart';
import 'package:weather_test/widgets/weather_container.dart';
import 'package:weather_test/widgets/dialogs.dart';
import 'package:weather_test/widgets/weather_utils.dart';

class LocationSelectorScreen extends StatefulWidget {
  LocationSelectorScreen({super.key});

  @override
  State<LocationSelectorScreen> createState() => _LocationSelectorScreenState();
}

class _LocationSelectorScreenState extends State<LocationSelectorScreen> {
  final TextEditingController _controller = TextEditingController();
  final WeatherService weatherService = WeatherService();
  List<String> cities = ['Sofia', 'Burgas', 'Varna', 'Plovdiv'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> submitHandler() async {
    try {
      validateInput(_controller.text);
      await fetchWeatherData(weatherService, _controller.text);
      Navigator.pushNamed(
        context,
        '/weather',
        arguments: _controller.text,
      );
    } catch (e) {
      showErrorDialog(context, "Wrong city, please enter again.");
    }
  }

  Future<void> _showAddCityDialog() async {
    String? cityName = await showCityInputDialog(context, "Add City");
    if (cityName != null && cityName.isNotEmpty) {
      try {
        await fetchWeatherData(weatherService, cityName);
        setState(() {
          cities.add(cityName);
        });
      } catch (e) {
        showErrorDialog(context, "Wrong city, please enter again.");
      }
    }
  }

  Future<void> _showRemoveCityDialog() async {
    String? cityName = await showCitySelectionDialog(context, "Remove City", cities);
    if (cityName != null && cityName.isNotEmpty) {
      setState(() {
        cities.remove(cityName);
      });
    }
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
            StyledTextfield(controller: _controller),
            const SizedBox(height: 16),
            SubmitButton(
              onPressed: submitHandler,
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.add, size: 40),
                  color: Colors.white,
                  onPressed: _showAddCityDialog,
                ),
                IconButton(
                  icon: Icon(Icons.remove, size: 40),
                  color: Colors.white,
                  onPressed: _showRemoveCityDialog,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: 375,
                child: FutureBuilder<List<Weather>>(
                  future: fetchMultipleCitiesWeather(weatherService, cities),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data'));
                    } else {
                      return ListView(
                        children: snapshot.data!
                            .map((weather) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: WeatherContainer(
                                    weather: weather,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/weather',
                                        arguments: weather.areaName,
                                      );
                                    },
                                  ),
                                ))
                            .toList(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
