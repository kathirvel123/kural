import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

class VoiceChatPage extends StatefulWidget {
  const VoiceChatPage({super.key});

  @override
  State<VoiceChatPage> createState() => _VoiceChatPageState();
}

class _VoiceChatPageState extends State<VoiceChatPage> {
  final SpeechToText _speechToText = SpeechToText();
  final AudioPlayer _audioPlayer = AudioPlayer();
  late IO.Socket socket;
  bool _isListening = false;
  bool _isConnected = false;
  bool _isPlaying = false;
  String _recognizedText = "Press and hold to speak...";
  String? localAudioPath;

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
    _connectToSocket();
  }

  // Initialize Speech Recognition
  void _initializeSpeech() async {
    await _speechToText.initialize();
  }

  // Connect to Flask-SocketIO Server
  void _connectToSocket() {
    socket = IO.io('http://172.16.3.50:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      setState(() => _isConnected = true);
      print("✅ Connected to Flask-SocketIO");
    });

    socket.onDisconnect((_) {
      setState(() => _isConnected = false);
      print("❌ Disconnected from server");
    });

    // Receive and Play Audio
    socket.on('audio_data', (data) async {
      if (data != null && data['audio'] != null) {
        await saveAndPlayAudio(data['audio']);
      } else {
        print("⚠️ Invalid audio data received");
      }
    });
  }

  // Start Speech Recognition
  void _startListening() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() => _isPlaying = false);
    }
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _isListening = true;
      _recognizedText = "Listening...";
    });
  }

  // Stop Speech Recognition and Send to Flask
  void _stopListening() async {
    await _speechToText.stop();
    setState(() => _isListening = false);

    if (_recognizedText.trim().isNotEmpty &&
        _recognizedText != "Press and hold to speak...") {
      // Emit recognized text to server
      if (_isConnected) {
        socket.emit('send_text', {"text": _recognizedText});
        print("📤 Sent to server: $_recognizedText");
      } else {
        print("⚠️ Not connected to server!");
      }
    }
  }

  // Speech-to-Text Callback
  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.recognizedWords.trim().isNotEmpty) {
      setState(() {
        _recognizedText = result.recognizedWords.trim();
      });
      print("🎙️ Recognized: $_recognizedText");
    }
  }

  // Save and Play Received Audio
  Future<void> saveAndPlayAudio(String base64Audio) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/received_audio.mp3';

      List<int> audioBytes = base64Decode(base64Audio);
      File file = File(filePath);
      await file.writeAsBytes(audioBytes);

      setState(() {
        localAudioPath = filePath;
        _isPlaying = true;
      });

      print("🔊 Playing received audio: $filePath");
      await _audioPlayer.play(DeviceFileSource(filePath));
    } catch (e) {
      print("⚠️ Error processing audio: $e");
    }
  }

  @override
  void dispose() {
    socket.disconnect();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Voice Chat"),
            backgroundColor: Colors.redAccent,
          ),
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    _recognizedText,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: GestureDetector(
            onLongPress: _startListening, // Start listening
            onLongPressUp: _stopListening, // Stop listening & send to server
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
