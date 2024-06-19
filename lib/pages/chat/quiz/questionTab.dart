import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
/* FIREBASE REQUIRED IMPORTS */
import 'package:firebase_core/firebase_core.dart';
import 'package:hackpue/components/appButton.dart';
import 'package:hackpue/components/appDropdown.dart';
import 'package:hackpue/components/appTextField.dart';
import 'package:hackpue/constants.dart';

class questionTab extends StatefulWidget {
  final int index;
  const questionTab({super.key, required this.index});

  @override
  State<questionTab> createState() => _questionTabState();
}

List<String> options = <String>['option 1', 'option 2', 'option 3'];
List<String> questions = <String>[
  'Question 1',
  'Question 2',
  'Question 3',
  'Question 4',
  'Question 5'
];

class _questionTabState extends State<questionTab> {
  String _defaultQuestion = '';
  String currentOption = options[0];

  // TEXT EDITING CONTROLLERS TO ADD SIMULATED SENSOR DATA TO FIREBASE:
  TextEditingController _emgValue = TextEditingController();
  TextEditingController _dateTime = TextEditingController();

  // CREATE ONDROPDOWN METHOD:
  void _dropDownCallback(String? selected) {
    if (selected is String) {
      setState(() {
        //value = selected;
      });
    }
  }

  // Define the dropdown value and initialize it

  String _dropdownValue = 'Bicep';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGlobal,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              questions[widget.index],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 85),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(options.first),
                    leading: Radio(
                        value: options.first,
                        groupValue: currentOption,
                        onChanged: (value) {
                          setState(() {
                            currentOption = value.toString();
                          });
                        }),
                  ),
                  ListTile(
                      title: Text(options[options.length - 2]),
                      leading: Radio(
                          value: options[options.length - 2],
                          groupValue: currentOption,
                          onChanged: (value) {
                            setState(() {
                              currentOption = value.toString();
                            });
                          })),
                  ListTile(
                      title: Text(options.last),
                      leading: Radio(
                          value: options.last,
                          groupValue: currentOption,
                          onChanged: (value) {
                            setState(() {
                              currentOption = value.toString();
                            });
                          })),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 20,
            ),
            AppButton(
              text: 'Send',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  // SEND SENSOR DATA METHOD:
  /*
  Future<void> singUpAndSendData() async {
    try {
      // IF SUCCESSFUL, THEN SEND USER DATA:
      User? newUser = FirebaseAuth.instance.currentUser;
      if (newUser != null) {
        await database.child(newUser.uid).set({
          'muscle': _dropdownValue,
          'emg value': _emgValue.text.trim(),
          'date': DateTime.now(),
        });
        print('Sensor data has been sent!');
      }
    } catch (error) {
      print('Error sending user sensor data: $error');
    }
  }
  */
}
