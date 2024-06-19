import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
/* FIREBASE REQUIRED IMPORTS */
import 'package:firebase_core/firebase_core.dart';
import 'package:hackpue/components/appTextField.dart';

class questionTab extends StatefulWidget {
  const questionTab({super.key});

  @override
  State<questionTab> createState() => _questionTabState();
}

class _questionTabState extends State<questionTab> {
  /* HOW TO SEND DATA TO REAL TIME DATABASE:

      1. Create an ainstance of our database.
        // a path to our real time database, wich when initialized,
        points to the top of our tree.
      2. Create a child to my reference inside my builder, wich will 
      refer (xd?) to my branches.
      3. Write data using <set> method.
        // This should be done in a JSON format, as follows:
        {
          'key': 'data',
          'key1': 'data1',
          'key3': 'data3',
        }

  */

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: _dropdownValue,
                items: muscles.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _dropdownValue = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              AppTextField(textt: 'holis'),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Send'),
                // PROPER SYNTAXIS TO WRITE DATA IN A JSON FORMAT.
              ),

              /*
              ElevatedButton(
                  onPressed: () {
                    // PROPER SYNTAXIS TO CHANGE DATA.
                    testWrite
                        .child('/child1/')
                        .set('another value')
                        .then((_) => print('Data values have been CHANGED!'))
                        .catchError((error) =>
                            print('Something didnt work! Error: $error'));
                    ;
                  },
                  child: Text('Press to change')),
              ElevatedButton(
                  onPressed: () {
                    // PROPER SYNTAXIS TO CHANGE/REPLACE DATA.
                    testWrite
                        .update({
                          'child2':
                              'value now equals = ${Random().nextInt(100)}'
                        })
                        .then((_) => print('Data values have been UPDATED!'))
                        .catchError((error) =>
                            print('Something didnt work! Error: $error'));
                    ;
                  },
                  child: Text('Press to update')),
              */
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
