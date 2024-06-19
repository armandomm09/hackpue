import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hackpue/components/appButton.dart';
import 'package:hackpue/components/appDropdown.dart';
import 'package:hackpue/components/appTextField.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/models/userInfo.dart';
import 'package:hackpue/services/chat/chatWithGpt.dart';
import 'package:hackpue/services/userInfo/UserInfoService.dart';

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

  uploadUserInfo() async {
    MyUserInfo userInfo =
        MyUserInfo(_disability, _hobbies, _age, _study, _interests);

    if (_disability.isNotEmpty &&
        _hobbies.isNotEmpty &&
        _age.isNotEmpty &&
        _study.isNotEmpty &&
        _interests.isNotEmpty) {
      if (kDebugMode) {
        print("\n \n FORMSSS: ");
        print("Disability $_disability");
        print("Hobbies $_hobbies");
        print("Age $_age");
        print("Study $_study");
        print("Interest $_interests");
      }

      PostState response = await UserInfoService.saveUserInfo(userInfo);
      _showMessage(response);
    } else {
      _showMessage(PostState.clientError);
    }
  }

  void _showMessage(PostState state) {
    final messenger = ScaffoldMessenger.of(context);
    final String title;
    final String message;
    final ContentType contentType;
    if (state == PostState.successful) {
      title = 'Nice!';
      message = "The match was posted";
      contentType = ContentType.success;
    } else if (state == PostState.isDuplicated) {
      title = "U sure?";
      message = "The match is duplicated";
      contentType = ContentType.warning;
    } else if (state == PostState.clientError) {
      title = "Oopss";
      message = "Some fields are missing";
      contentType = ContentType.help;
    } else {
      title = 'Shoot!!';
      message = "Something went wrong, try again later or save the QR Code";
      contentType = ContentType.failure;
    }
    final snackBar = SnackBar(
        elevation: 0,
        //AppText(text: message, fontSize: 25,),
        content: AwesomeSnackbarContent(
            title: title, message: message, contentType: contentType),
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.transparent);
    messenger.showSnackBar(snackBar);
  }

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
