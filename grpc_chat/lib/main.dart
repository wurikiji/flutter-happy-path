import 'package:flutter/material.dart';
import 'package:grpc_chat/src/client.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  MyWidget({super.key});

  final chatService = ChatClient();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ChatOutput(
                chatService: chatService,
              ),
            ),
            SizedBox(
              height: 44,
              child: ChatInput(
                chatService: chatService,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatOutput extends StatefulWidget {
  const ChatOutput({super.key, required this.chatService});

  final ChatClient chatService;

  @override
  State<ChatOutput> createState() => _ChatOutputState();
}

class _ChatOutputState extends State<ChatOutput> {
  final List _messages = <String>[];
  @override
  void initState() {
    super.initState();
    widget.chatService.connect().listen((message) {
      print("Get message: $message");
      setState(() {
        _messages.add(message.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (context, index) => Text(_messages[index]),
    );
  }
}

class ChatInput extends StatelessWidget {
  ChatInput({super.key, required this.chatService});
  final ChatClient chatService;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      child: TextField(
        controller: textController,
        onSubmitted: (text) {
          print("Send $text");
          chatService.send(text);
          textController.clear();
        },
      ),
    );
  }
}
