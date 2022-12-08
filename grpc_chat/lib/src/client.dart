import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc_chat/src/generated/grpc_chat.pbgrpc.dart';

import './web_dummy.dart' if (dart.library.html) 'package:grpc/grpc_web.dart';

class ChatClient {
  late ClientChannelBase _channel;
  late GrpcChatClient _stub;
  final _chatController = StreamController<String>();
  ChatClient() {
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isFuchsia ||
        Platform.isLinux ||
        Platform.isMacOS ||
        Platform.isWindows) {
      print("Use platform client");
      _channel = ClientChannel(
        'localhost',
        port: 8080,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
    } else {
      print("Use web client");
      _channel = GrpcWebClientChannel.xhr(
        Uri.parse('http://localhost:8080'),
      );
    }
    _stub = GrpcChatClient(
      _channel,
    );
  }

  Stream<Message> connect() {
    final messageStream = _chatController.stream.map((message) => Message(
          text: message,
        ));

    final call = _stub.chat(messageStream);
    return call;
  }

  send(String message) {
    try {
      _chatController.add(message.trim());
    } catch (e) {
      print(e);
    }
  }
}
