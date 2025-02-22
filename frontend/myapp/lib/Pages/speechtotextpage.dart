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
  bool _speechEnable = false;
  String _wordSpoken = "";
  double _confidenceLevel = 0.0;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnable = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _confidenceLevel = 0.0;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _wordSpoken = result.recognizedWords;
      _confidenceLevel = result.confidence;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DEMO',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _speechToText.isListening
                  ? "Listening..."
                  : _speechEnable
                      ? "Tap the microphone to start listening..."
                      : "Speech recognition not available",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _wordSpoken,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (!_speechToText.isListening && _confidenceLevel > 0)
              Text(
                "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _speechToText.isListening ? _stopListening : _startListening,
        tooltip: 'Listen',
        backgroundColor: Colors.red,
        child: Icon(
          _speechToText.isListening ? Icons.mic : Icons.mic_off,
          color: Colors.white,
        ),
      ),
    );
  }
}
