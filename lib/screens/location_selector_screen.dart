import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather/weather.dart';
import 'package:weather_test/services/services.dart';
import 'package:weather_test/widgets/submit_button.dart';
import 'package:weather_test/widgets/weather_container.dart';

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

  Future<void> _showAddCityDialog() async {
    String? cityName = await _showCityInputDialog("Add City");
    if (cityName != null && cityName.isNotEmpty) {
      setState(() {
        cities.add(cityName);
      });
    }
  }

  Future<void> _showRemoveCityDialog() async {
    String? cityName = await _showCitySelectionDialog("Remove City");
    if (cityName != null && cityName.isNotEmpty) {
      setState(() {
        cities.remove(cityName);
      });
    }
  }

  Future<String?> _showCityInputDialog(String title) async {
    TextEditingController dialogController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: dialogController,
            decoration: InputDecoration(labelText: 'City Name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.of(context).pop(dialogController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<String?> _showCitySelectionDialog(String title) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: cities
                  .map((city) => ListTile(
                        title: Text(city),
                        onTap: () {
                          Navigator.of(context).pop(city);
                        },
                      ))
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<Weather>> _fetchMultipleCitiesWeather() async {
    List<Future<Weather>> weatherFutures =
        cities.map((city) => weatherService.getCurrentWeather(city)).toList();
    return await Future.wait(weatherFutures);
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
                  icon: Icon(Icons.add, size: 40,),
                  color: Colors.white,
                  onPressed: _showAddCityDialog,
                ),
                IconButton(
                  icon: Icon(Icons.remove, size: 40,),
                  color: Colors.white,
                  onPressed: _showRemoveCityDialog,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: 400,
                child: FutureBuilder<List<Weather>>(
                  future: _fetchMultipleCitiesWeather(),
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
