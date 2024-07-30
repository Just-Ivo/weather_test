import 'package:flutter/material.dart';

class StyledTextfield extends StatelessWidget {
  const StyledTextfield({
    super.key,
    required this.controller,
    });
  final controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
              controller: controller,
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
                label: Text('City name'),
                iconColor: Colors.white,
                filled: false,
                isDense: true,
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                
              ),
              
              maxLength: 20,
              
            );
  }
}