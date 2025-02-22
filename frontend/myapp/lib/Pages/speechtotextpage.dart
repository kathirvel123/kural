import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Speechtotextpage extends StatefulWidget {
  const Speechtotextpage({super.key});

  @override
  State<Speechtotextpage> createState() => _SpeechtotextpageState();
}

class _SpeechtotextpageState extends State<Speechtotextpage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _recognizedText = "Press and hold to speak...";

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    await _speechToText.initialize();
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
      _recognizedText = _speechToText.lastRecognizedWords.isNotEmpty
          ? _speechToText.lastRecognizedWords
          : "No speech detected.";
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _recognizedText = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Speech to Text')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _recognizedText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onLongPress: _startListening,
        onLongPressUp: _stopListening,
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isListening ? Colors.green : Colors.red,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Icon(
            Icons.mic,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
