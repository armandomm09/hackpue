import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/app_intro/services.dart';
import 'package:hackpue/pages/chat/chat_with_database.dart';
import 'package:hackpue/pages/chat/upload_audio.dart';
import 'package:hackpue/services/chat/chatWithGpt.dart';
import 'package:http/http.dart' as http;

class AskGPTWithFile extends StatefulWidget {
  @override
  _AskGPTWithFileState createState() => _AskGPTWithFileState();
}

class _AskGPTWithFileState extends State<AskGPTWithFile> {
  File? _selectedFile;
  String? _uploadStatus;
  bool _isUploading = false;
  var requestBody = {};
  String? uploadedFilePath;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _uploadStatus = null; // Reset the upload status
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null) {
      setState(() {
        _uploadStatus = 'No file selected';
      });
      return;
    }

    setState(() {
      _isUploading = true;
      _uploadStatus = 'Uploading...';
    });

    final uri = Uri.parse('http://live.galliard.mx/api/v1/upload_file/');
    final request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath(
      'file', // The name of the field in the form
      _selectedFile!.path,
      filename: _selectedFile!.path
          .split('/')
          .last, // Extracting filename from the path
    ));

    try {
      final response = await request.send();
      var newResponse = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        setState(() {
          requestBody = jsonDecode(utf8.decode(newResponse.bodyBytes));
          _uploadStatus = 'File uploaded successfully';
        });
        setState(() {
          uploadedFilePath = requestBody['location'];
        });
        print(uploadedFilePath);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatWithDatabase(),
          ),
        );
        await GPTService.askViaPDF(uploadedFilePath!);
      } else {
        setState(() {
          _uploadStatus = 'Upload failed: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _uploadStatus = 'Error: $e';
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask GPT with File'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(happyOrange),
                    fixedSize: MaterialStatePropertyAll(Size(
                      100,
                      100,
                    ))),
                onPressed: _pickFile,
                child: Icon(
                  Icons.file_open_rounded,
                  size: 50,
                  color: happyYellow,
                ),
              ),
              SizedBox(height: 20),
              if (_selectedFile != null)
                Text(
                  'Selected file: ${_selectedFile!.path.split('/').last}',
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(lavender)),
                onPressed: _isUploading ? null : _uploadFile,
                child: Text(
                  _isUploading ? 'Uploading...' : 'Upload File',
                  style: TextStyle(color: backgroundGlobal),
                ),
              ),
              SizedBox(height: 20),
              if (_uploadStatus != null)
                Text(
                  _uploadStatus!,
                  style: TextStyle(
                    fontSize: 16,
                    color: _uploadStatus!.contains('successfully')
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
