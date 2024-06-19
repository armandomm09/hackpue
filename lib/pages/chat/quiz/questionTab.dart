import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
/* FIREBASE REQUIRED IMPORTS */
import 'package:firebase_core/firebase_core.dart';
import 'package:hackpue/components/appDropdown.dart';
import 'package:hackpue/components/appTextField.dart';
import 'package:hackpue/constants.dart';

class questionTab extends StatefulWidget {
  const questionTab({super.key});

  @override
  State<questionTab> createState() => _questionTabState();
}

class _questionTabState extends State<questionTab> {
  String _defaultQuestion = '';

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
  List<String> muscles = <String>['Bicep', 'Tricep', 'Tronador', 'Deltoides'];
  String _dropdownValue = 'Bicep';

  @override
  void initState() {
    super.initState();
    _dropdownValue = muscles.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: happyYellow,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Question 1',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 50),
              appDropdown(
                  defaultValue: '1',
                  textColor: defaultText,
                  width: 200,
                  list: ['1', '2', '3'],
                  theme: 'question',
                  dropdownColor: lavender,
                  onChanged: (p0) {
                    setState(() {
                      _defaultQuestion = p0!;
                    });
                  }),
              SizedBox(height: 20),
              Container(
                child: AppTextField(textt: 'holis'),
                width: 200,
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Send'),
                // PROPER SYNTAXIS TO WRITE DATA IN A JSON FORMAT.
              ),
            ],
          ),
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
