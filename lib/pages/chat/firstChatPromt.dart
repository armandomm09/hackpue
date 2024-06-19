import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hackpue/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class FirstPromptChat extends StatefulWidget {
  const FirstPromptChat({super.key});

  @override
  _FirstPromptChatState createState() => _FirstPromptChatState();
}

class _FirstPromptChatState extends State<FirstPromptChat> {
  final TextEditingController _textController = TextEditingController();
  String? _selectedFile;
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackGroundColor,
      appBar: AppBar(
        title: Text(
          'First Prompt Chat',
          style: TextStyle(
            color: myTitleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: appBarBackgorundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Escribe un texto, graba un audio o sube un archivo para iniciar tu conversación con ChatGPT:',
                style: formLabelTextStyle,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Escribir texto',
                  labelStyle: formLabelTextStyle,
                  filled: true,
                  fillColor: formInputBackgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: Icon(Icons.upload_file),
                label: Text('Subir Archivo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              if (_selectedFile != null)
                Text(
                  'Archivo seleccionado: $_selectedFile',
                  style: formLabelTextStyle,
                ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _isRecording ? null : () {},
                icon: Icon(_isRecording ? Icons.mic_off : Icons.mic),
                label: Text(_isRecording ? 'Grabando...' : 'Grabar Audio'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: lavender,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: Text('Enviar Prompt'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: pink,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = result.files.single.name;
      });
    }
  }
}
