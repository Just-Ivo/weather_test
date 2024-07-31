import 'package:flutter/material.dart';
import 'package:weather_test/widgets/style_widgets/cancel_icon.dart';
import 'package:weather_test/widgets/style_widgets/dialog_button.dart';
import 'package:weather_test/widgets/style_widgets/styledtext.dart';
import 'package:weather_test/widgets/style_widgets/textfield.dart';

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(24),
              width: 350,
              height: 450,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/burning_plane.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  StyledText(
                    'Wrong City',
                    18,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 32,
              right: 32,
              child: DialogButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'OK'),
            ),
            CancelIcon(),
          ],
        ),
      );
    },
  );
}

Future<String?> showCityInputDialog(BuildContext context, String title) {
  TextEditingController dialogController = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(24),
              padding: EdgeInsets.all(24),
              width: 450,
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/addcity.jpg'), fit: BoxFit.cover),
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Column(
                    children: [
                      StyledText('Enter City Name', 16),
                      SizedBox(
                        height: 10,
                      ),
                      StyledTextfield(controller: dialogController),
                    ],
                  )),
            ),
            CancelIcon(),
            Positioned(
              bottom: 36,
              right: 36,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color.fromARGB(255, 0, 46, 84),
                      Colors.black,
                      const Color.fromARGB(255, 0, 46, 84),
                    ]),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    TextButton(
                      child: StyledText('Cancel', 12),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: StyledText('OK', 12),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).pop(dialogController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<String?> showCitySelectionDialog(
    BuildContext context, String title, List<String> cities) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(24),
              padding: EdgeInsets.all(24),
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/addcity.jpg'), fit: BoxFit.cover),
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  StyledText('Remove City', 18),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: cities
                            .map((city) => ListTile(
                                  title: StyledText(city, 16),
                                  onTap: () {
                                    Navigator.of(context).pop(city);
                                  },
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CancelIcon(),
            Positioned(
              bottom: 36,
              right: 36,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color.fromARGB(255, 0, 46, 84),
                      Colors.black,
                      const Color.fromARGB(255, 0, 46, 84),
                    ]),
                    borderRadius: BorderRadius.circular(8)),
                child: TextButton(
                  child: StyledText('Cancel', 12),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
