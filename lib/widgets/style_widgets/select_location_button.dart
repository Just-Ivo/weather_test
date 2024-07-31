import 'package:flutter/material.dart';
import 'package:weather_test/widgets/style_widgets/styledtext.dart';

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
          color: Colors.grey,
          width: 2.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: const StyledText(
          'Select Location',
          18
          ),
        ),
      );
  
  }
}
