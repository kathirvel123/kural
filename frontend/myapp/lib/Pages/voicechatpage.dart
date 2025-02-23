import 'package:flutter/material.dart';
import 'package:myapp/widgets/Ownmessagecard.dart';
import 'package:myapp/widgets/Replymessagecard.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Voicechatpage extends StatefulWidget {
  const Voicechatpage({super.key});

  @override
  State<Voicechatpage> createState() => _VoicechatpageState();
}

class _VoicechatpageState extends State<Voicechatpage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _recognizedText = "Press and hold to speak...";
  List<Widget> messages = [];

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
      if (_speechToText.lastRecognizedWords.isNotEmpty) {
        messages.add(Ownmessagecard());
        messages.add(Replymessagecard());
      }
    });
    print(_recognizedText);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _recognizedText = result.recognizedWords;
    }
    
    );
    print(_recognizedText);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/chatimage.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            titleSpacing: 0,
            leadingWidth: 70,
            backgroundColor: Colors.redAccent,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () async {
                Navigator.pop(context);
                return true;
              },
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 140,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Ownmessagecard(),
                        Replymessagecard(),
                        Ownmessagecard(),
                        Replymessagecard(),
                        Ownmessagecard(),
                        Replymessagecard(),
                        Ownmessagecard(),
                        Replymessagecard(),
                        Ownmessagecard(),
                        Replymessagecard(),
                        Ownmessagecard(),
                        Replymessagecard(),
                        Ownmessagecard(),
                        Replymessagecard(),
                      ],
                    ),
                  ),],
              ),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ],
    );
  }
}
