import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
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

Future<String?> showCityInputDialog(BuildContext context, String title) {
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

Future<String?> showCitySelectionDialog(BuildContext context, String title, List<String> cities) {
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
