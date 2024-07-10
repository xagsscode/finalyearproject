import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceChat extends StatefulWidget {
  @override
  _VoiceChatState createState() => _VoiceChatState();
}

class _VoiceChatState extends State<VoiceChat> {
  final TextEditingController _textController = TextEditingController();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  var _speechEnabled = false;
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    _addMessage(text, 'normal');
  }

  void _addMessage(String text, String sender) {
    ChatMessage message = ChatMessage(
      text: text,
      sender: sender,
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _startListening() async {
    if (!_speechToText.isAvailable) {
      print('Speech recognition is not available.');
      return;
    }
    await _speechToText.listen(
      onResult: (result) => _handleSubmitted(result.recognizedWords),
    );
  }

  _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _showMessageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Type your message"),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration.collapsed(
                hintText: 'Type your message...', border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _handleSubmitted(_textController.text);
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deaf Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: 600,
              margin: const EdgeInsets.all(0),
              child: ListView.separated(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10, left: 10),
            child: FloatingActionButton.extended(
              heroTag: 'Text',
              label: Text('Text'),

              onPressed: () {
                _showMessageDialog();
              },
              icon: Icon(Icons.message),
              backgroundColor: AppColors.mainColor, // Adjust color as needed
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10, right: 10),
            child: FloatingActionButton.extended(
              label: Text('Mic'),
              heroTag: 'voice',
              onPressed: _speechToText.isListening
                  ? _stopListening()
                  : _startListening,
              icon: Icon(
                  _speechToText.isNotListening ? Icons.mic : Icons.mic_none),
              backgroundColor: AppColors.mainColor, // Adjust color as needed
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String sender;

  ChatMessage({required this.text, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: sender == 'normal'
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: Text(
              sender == 'normal' ? 'CHATS' : 'Deaf User',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: sender == 'normal'
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                  margin: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Text(
                      text,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
