import 'dart:convert';
import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:hackpue/constants.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class AudioToTextPage extends StatefulWidget {
  @override
  _AudioToTextPageState createState() => _AudioToTextPageState();
}

class _AudioToTextPageState extends State<AudioToTextPage> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _recordedFilePath;
  String _transcribedText = 'Empieza a hablar';

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    await Permission.storage.request();
    await _recorder.openRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  Future<void> _startRecording() async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/temp_audio.aac';
    await _recorder.startRecorder(toFile: filePath);
    setState(() {
      _isRecording = true;
      _recordedFilePath = filePath;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
    _transcribeAudio(); // Trigger transcription automatically
  }

  Future<void> _transcribeAudio() async {
    if (_recordedFilePath == null) return;

    setState(() {
      _transcribedText = 'Transcribing...';
    });

    try {
      final file = File(_recordedFilePath!);
      final bytes = await file.readAsBytes();
      final uri = Uri.parse('https://api.openai.com/v1/audio/transcriptions');
      final request = http.MultipartRequest('POST', uri);

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: 'audio.aac',
      ));
      request.fields['model'] = 'whisper-1';
      request.headers['Authorization'] = 'Bearer YOUR_OPENAI_API_KEY';

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final Map<String, dynamic> responseBody = jsonDecode(responseData.body);
        setState(() {
          _transcribedText = responseBody['text'] ?? 'Transcription failed';
        });
      } else {
        setState(() {
          _transcribedText = 'Hubo un error! ';
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _transcribedText = 'Error during transcription';
      });
    }
  }

  Widget showIcon(bool isListening) {
    if (isListening) {
      return Icon(
        Icons.mic,
        color: happyYellow,
      );
    } else {
      return Icon(
        Icons.mic_none,
        color: lavender,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Audio to Text',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isRecording,
        glowColor: pink,
        //endRadius: 75.0,
        duration: Duration(milliseconds: 2000),
        repeat: true,
        //showTwoGlows: true,
        //repeatPauseDuration: Duration(milliseconds: 100),
        child: FloatingActionButton(
          onPressed: _isRecording ? _stopRecording : _startRecording,
          child: showIcon(_isRecording),
          backgroundColor: _isRecording ? happyOrange : happyYellow,
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                _transcribedText,
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
