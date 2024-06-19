import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hackpue/components/appButton.dart';
import 'package:hackpue/components/appDropdown.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/models/userInfo.dart';
import 'package:hackpue/pages/app_intro/mainPage.dart';
import 'package:hackpue/pages/app_intro/services.dart';
import 'package:hackpue/services/chat/chatWithGpt.dart';
import 'package:hackpue/services/userInfo/UserInfoService.dart';

class UserInfoFormScreen extends StatefulWidget {
  const UserInfoFormScreen({super.key});

  @override
  _UserInfoFormScreenState createState() => _UserInfoFormScreenState();
}

class _UserInfoFormScreenState extends State<UserInfoFormScreen> {
  String _disability = 'Seleccionar'; // Valor predeterminado
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
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    fit: BoxFit.fill,
                    height: 100,
                    image: AssetImage('assets/images/fondoblanco.png'),
                  ),
                  Text(
                    '¡Sólo hacen falta unos cuantos datos',
                    style: TextStyle(fontSize: 15, color: defaultText),
                  ),
                  Text(
                    'datos para empezar a aprender!',
                    style: TextStyle(fontSize: 15, color: defaultText),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  appDropdown(
                    width: 400,
                    defaultValue: _disability,
                    list: ['ADHD', 'Dislexia', 'TA', 'Seleccionar'],
                    theme: 'Discapacidad',
                    textColor: defaultText,
                    dropdownColor: happyYellow,
                    onChanged: (p0) {
                      setState(() {
                        _disability = p0!;
                      });
                    },
                  ),
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
                    onChanged: (newValue) {
                      _hobbies = newValue;
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
                    onChanged: (newValue) {
                      _age = newValue;
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
                    onChanged: (newValue) {
                      _study = newValue;
                    },
                    style: TextStyle(color: deepPurple),
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
                    onChanged: (newValue) {
                      _interests = newValue;
                    },
                    style: TextStyle(color: deepPurple),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppButton(
                        text: 'Guardar',
                        onPressed: () async {
                          await uploadUserInfo();
                        },
                      ),
                      AppButton(
                        text: 'Continuar',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AppServices()));
                        },
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
