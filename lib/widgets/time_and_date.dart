import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeAndDate extends StatelessWidget {

  final String formattedDate;
  final String formattedTime;

  const TimeAndDate({
    super.key,
    required this.formattedDate,
    required this.formattedTime,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          formattedDate,
          style: GoogleFonts.kalnia(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Text(
          formattedTime,
          style: GoogleFonts.kalnia(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ]
    );
  }
}