import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_test/widgets/submit_button.dart';

class LocationSelectorScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  LocationSelectorScreen({super.key});

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
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/weather',
                    arguments: _controller.text,
                  );
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
