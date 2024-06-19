import 'package:flutter/material.dart';
import 'package:hackpue/components/appButton.dart';
import 'package:hackpue/components/appDropdown.dart';
import 'package:hackpue/components/appTextField.dart';
import 'package:hackpue/constants.dart';

class UserInfoFormScreen extends StatefulWidget {
  const UserInfoFormScreen({super.key});

  @override
  _UserInfoFormScreenState createState() => _UserInfoFormScreenState();
}

class _UserInfoFormScreenState extends State<UserInfoFormScreen> {
  String _disability = 'TA'; // Valor predeterminado
  String _hobbies = '';
  String _age = '';
  String _study = '';
  String _interests = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGlobal,
      appBar: AppBar(
        title: Text(
          'Sobre mí',
          style: TextStyle(color: defaultText),
        ),
        backgroundColor: happyYellow,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¡Sólo hacen falta unos cuantos datos',
                  style: TextStyle(fontSize: 15, color: defaultText),
                ),
                Text(
                  'datos para empezar a aprender!',
                  style: TextStyle(fontSize: 15, color: defaultText),
                ),
                SizedBox(
                  height: 20,
                ),
                appDropdown(
                    defaultValue: _disability,
                    list: ['ADHD', 'Dislexia', 'TA']),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Hobbies',
                    labelStyle: TextStyle(color: deepPurple),
                    filled: true,
                    fillColor: formInputBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSaved: (newValue) {
                    _hobbies = newValue!;
                  },
                  style: TextStyle(color: deepPurple),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Edad',
                    labelStyle: TextStyle(color: deepPurple),
                    filled: true,
                    fillColor: formInputBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    _age = newValue!;
                  },
                  style: TextStyle(color: deepPurple),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Qué estudias',
                    labelStyle: TextStyle(color: deepPurple),
                    filled: true,
                    fillColor: formInputBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSaved: (newValue) {
                    _study = newValue!;
                  },
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Temas de Interés',
                    labelStyle: TextStyle(color: deepPurple),
                    filled: true,
                    fillColor: formInputBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSaved: (newValue) {
                    _interests = newValue!;
                  },
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 30),
                AppButton(text: 'Guardar')
              ],
            )),
      ),
    );
  }

  void onSaved(String myValue, String newValue) {
    setState(() {
      myValue = newValue!;
    });
  }
}
