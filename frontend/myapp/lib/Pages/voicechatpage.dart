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
       if (_recognizedText.isNotEmpty &&
          _recognizedText != "Press and hold to speak...") {
        messages.add(Ownmessagecard(message: _recognizedText));
        messages.add(Replymessagecard()); 
      }
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _recognizedText = result.recognizedWords;
    });
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
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () async {
                Navigator.pop(context);
                return true;
              },
              child: Stack(
                children: [
                  messages.isEmpty
                      ? Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.chat, size: 50, color: Colors.blue),
                                SizedBox(height: 10),
                                Text(
                                  "Start a new conversation",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "No messages yet. Hold the mic to start talking!",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) => messages[index],
                        ),
                ],
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
