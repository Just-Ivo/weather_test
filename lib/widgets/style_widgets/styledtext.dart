import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StyledText extends StatelessWidget {
  const StyledText(this.text, this.size, {super.key});

  final text;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.playfairDisplay(
        color: Colors.white.withOpacity(1),
        letterSpacing: 2.5,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
      );
  }
}