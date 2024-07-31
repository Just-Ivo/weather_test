import 'package:flutter/material.dart';

class SelectLocationButton extends StatelessWidget {
  const SelectLocationButton({
    super.key,
    required this.onPressed,
    //required this.child,
    });

    //final Widget child;
    final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.black,
            Colors.grey,
            Colors.black,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color.fromARGB(0, 76, 34, 34).withOpacity(1),
          width: 2.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: const Text(
          'Select Location',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
