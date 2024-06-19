import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  String _disability = 'Autismo'; // Valor predeterminado
  String _hobbies = '';
  String _age = '';
  String _study = '';
  String _interests = '';

  void  _showMessage(PostState state) {
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
    } else if(state == PostState.clientError){
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
      backgroundColor: myBackGroundColor,
      appBar: AppBar(
        title: Text(
          'Formulario de Información',
          style: TextStyle(color: myTitleColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: appBarBackgorundColor,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Información Personal',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Discapacidad',
                  labelStyle:
                      TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  filled: true,
                  fillColor: formInputBackgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: _disability,
                items:
                    <String>['Autismo', 'ADHD', 'Dislexia'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _disability = newValue!;
                  });
                },
                style: const TextStyle(color: Colors.white),
                dropdownColor: const Color.fromARGB(255, 87, 85, 128),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Hobbies',
                  labelStyle:
                      TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  filled: true,
                  fillColor: formInputBackgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (newValue) {
                  _hobbies = newValue;
                },
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Edad',
                  labelStyle:
                      TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
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
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Qué estudias',
                  labelStyle:
                      TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  filled: true,
                  fillColor: formInputBackgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (newValue) {
                  _study = newValue;
                },
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Temas de Interés',
                  labelStyle:
                      TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  filled: true,
                  fillColor: formInputBackgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (newValue) {
                  _interests = newValue;
                },
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  MyUserInfo userInfo = MyUserInfo(
                      _disability, _hobbies, _age, _study, _interests);

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
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 28, 48, 225),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Guardar'),
              ),
            ],
          )),
    );
  }
}
