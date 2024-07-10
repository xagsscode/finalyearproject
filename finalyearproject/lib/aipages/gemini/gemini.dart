import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_gemini/google_gemini.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

const apiKey = "AIzaSyC41me8WpQIsPnpn13QjPBOZxkfUD3wEZc";

class ChatHistory extends ChangeNotifier {
  List<Map<String, String>> messages = [];

  void addMessage(String role, String text) {
    messages.add({"role": role, "text": text});
    notifyListeners();
  }
}

class GeminiPage extends StatefulWidget {
  const GeminiPage({
    Key? key,
  }) : super(key: key);

  @override
  State<GeminiPage> createState() => _GeminiPageState();
}

class _GeminiPageState extends State<GeminiPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BUK Gemini"),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Text Only"),
              Tab(text: "Text with Image"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TextOnly(),
            TextWithImage(),
          ],
        ),
      ),
    );
  }
}

class TextOnly extends StatefulWidget {
  const TextOnly({
    Key? key,
  }) : super(key: key);

  @override
  State<TextOnly> createState() => _TextOnlyState();
}

class _TextOnlyState extends State<TextOnly> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null) {
      user = auth.currentUser;
    }
  }

  bool loading = false;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  final gemini = GoogleGemini(
    apiKey: apiKey,
  );

  void fromText({required String query, required ChatHistory chatHistory}) {
    setState(() {
      loading = true;
      chatHistory.addMessage("${user?.displayName}", query);
      _textController.clear();
    });
    scrollToTheEnd();

    gemini.generateFromText(query).then((value) {
      setState(() {
        loading = false;
        chatHistory.addMessage("Bayero-University-Gemini", value.text);
      });
      scrollToTheEnd();
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        chatHistory.addMessage("Gemini", error.toString());
      });
      scrollToTheEnd();
    });
  }

  void scrollToTheEnd() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    final chatHistory = Provider.of<ChatHistory>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: chatHistory.messages.length,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                return ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    child: Text(
                        chatHistory.messages[index]["role"]!.substring(0, 1)),
                  ),
                  title: Text(chatHistory.messages[index]["role"]!),
                  subtitle: Text(chatHistory.messages[index]["text"]!),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.transparent,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                IconButton(
                  icon: loading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.send),
                  onPressed: () {
                    fromText(
                        query: _textController.text, chatHistory: chatHistory);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------ Text with Image ------------------------------

class TextWithImage extends StatefulWidget {
  const TextWithImage({Key? key}) : super(key: key);

  @override
  State<TextWithImage> createState() => _TextWithImageState();
}

class _TextWithImageState extends State<TextWithImage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null) {
      user = auth.currentUser;
    }
  }

  bool loading = false;
  List<Map<String, dynamic>> textAndImageChat = [];
  File? imageFile;

  final ImagePicker picker = ImagePicker();

  final TextEditingController _textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  final gemini = GoogleGemini(
    apiKey: apiKey,
  );

  void fromTextAndImage(
      {required String query,
      required File image,
      required ChatHistory chatHistory}) {
    setState(() {
      loading = true;
      chatHistory.addMessage("${user?.displayName}", query);
      textAndImageChat.add({
        "role": "${user?.displayName}",
        "text": query,
        "image": image,
      });
      _textController.clear();
      imageFile = null;
    });
    scrollToTheEnd();

    gemini.generateFromTextAndImages(query: query, image: image).then((value) {
      setState(() {
        loading = false;
        chatHistory.addMessage("Bayero-University-Gemini", value.text);
        textAndImageChat.add({
          "role": "Bayero-University-Gemini",
          "text": value.text,
          "image": ""
        });
      });
      scrollToTheEnd();
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        chatHistory.addMessage("Gemini", error.toString());
        textAndImageChat
            .add({"role": "Gemini", "text": error.toString(), "image": ""});
      });
      scrollToTheEnd();
    });
  }

  void scrollToTheEnd() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    final chatHistory = Provider.of<ChatHistory>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: textAndImageChat.length,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                return ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    child: Text(
                      textAndImageChat[index]["role"].substring(0, 1),
                    ),
                  ),
                  title: Text(textAndImageChat[index]["role"]),
                  subtitle: Text(textAndImageChat[index]["text"]),
                  trailing: textAndImageChat[index]["image"] == ""
                      ? null
                      : Image.file(
                          textAndImageChat[index]["image"],
                          width: 90,
                        ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: "Write a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.transparent,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: () async {
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      imageFile = image != null ? File(image.path) : null;
                    });
                  },
                ),
                IconButton(
                  icon: loading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.send),
                  onPressed: () {
                    if (imageFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select an image"),
                        ),
                      );
                      return;
                    }
                    fromTextAndImage(
                      query: _textController.text,
                      image: imageFile!,
                      chatHistory: chatHistory,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: imageFile != null
          ? Container(
              margin: const EdgeInsets.only(bottom: 80),
              height: 150,
              child: Image.file(imageFile!),
            )
          : null,
    );
  }
}
