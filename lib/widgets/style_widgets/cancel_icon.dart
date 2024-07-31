import 'package:flutter/material.dart';


class CancelIcon extends StatelessWidget {
  const CancelIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
              top: 0,
              right: 0,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.all(8),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.cancel,
                  size: 50,
                  color: Colors.red,
                ),
              ),
            );
  }
}