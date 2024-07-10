import 'dart:async';

import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key});

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  String _wordsSpoken = "";
  double _confidenceLevel = 0;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  Duration _selectedDuration = const Duration();
  Timer? _countdownTimer;
  @override
  void initState() {
    super.initState();

    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    if (_selectedDuration.inSeconds > 0) {
      _startCountdown(_selectedDuration);
      await _speechToText.listen(
          onResult: _onSpeechResult, listenFor: _selectedDuration);
      setState(() {
        _confidenceLevel = 0;
      });
    } else {
      // Handle case where no duration is selected
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: const Text(
              'Please select a duration before starting speech recognition.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;
    });
  }

  _startCountdown(Duration duration) {
    setState(() {
      _selectedDuration = duration;
      _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_selectedDuration.inSeconds > 0) {
          _selectedDuration -= Duration(seconds: 1);
        } else {
          _countdownTimer?.cancel();
          _stopListening();
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Lecture Key Points"),
        actions: [
          Container(
            child: TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _wordsSpoken));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Text copied to clipboard')),
                  );
                },
                child: Icon(Icons.copy)),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                _speechToText.isListening
                    ? "Listening....."
                    : _speechEnabled
                        ? "Select Duration or\nTap the microphone to start noting...."
                        : "Speech not available",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Text(
                  _wordsSpoken,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
              ),
            )),
            if (_speechToText.isNotListening && _confidenceLevel > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Text(
                  "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 30),
              child: FloatingActionButton.extended(
                label: Text('Duration', style: TextStyle(color: Colors.white)),
                heroTag: 'Duration',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Select Duration'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _startCountdown(Duration(minutes: 30));
                              _speechToText.listen(
                                  listenFor: _selectedDuration);
                              Navigator.pop(context);
                            },
                            child: Text('30 minutes'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _startCountdown(Duration(hours: 1));
                              _speechToText.listen(
                                  listenFor: _selectedDuration);
                              Navigator.pop(context);
                            },
                            child: Text('1 hour'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _startCountdown(Duration(hours: 2));
                              _speechToText.listen(
                                  listenFor: _selectedDuration);
                              Navigator.pop(context);
                            },
                            child: Text('2 hours'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _startCountdown(Duration(hours: 3));
                              _speechToText.listen(
                                  listenFor: _selectedDuration);
                              Navigator.pop(context);
                            },
                            child: Text('3 hours'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _startCountdown(Duration(hours: 4));
                              _speechToText.listen(
                                  listenFor: _selectedDuration);
                              Navigator.pop(context);
                            },
                            child: Text('4 hours'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                tooltip: "Select Duration",
                icon: Icon(Icons.timer, color: Colors.white),
                backgroundColor: AppColors.mainColor,
              ),
            ),
            if (_selectedDuration.inSeconds > 0)
              Text(
                '${_selectedDuration.inHours}:${(_selectedDuration.inMinutes % 60).toString().padLeft(2, '0')}:${(_selectedDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            Container(
              child: FloatingActionButton.extended(
                label: Text('Note', style: TextStyle(color: Colors.white)),
                heroTag: 'Note',
                onPressed: _speechToText.isListening
                    ? _stopListening
                    : _startListening,
                tooltip: "Listen",
                icon: Icon(
                  _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                  color: Colors.white,
                ),
                backgroundColor: AppColors.mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
