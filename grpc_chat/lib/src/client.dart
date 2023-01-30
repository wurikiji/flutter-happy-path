import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc_chat/src/generated/grpc_chat.pbgrpc.dart';

import 'channel_platform.dart' if (dart.library.html) 'channel_web.dart';

class ChatClient {
  late ClientChannelBase _channel;
  late GrpcChatClient _stub;
  late ResponseStream<Message> _responseStream;
  final _chatController = StreamController<String>();

  ChatClient() {
    _channel = getClientChannel();
    _stub = GrpcChatClient(
      _channel,
    );
  }

  Stream<Message> connect() {
    final messageStream = _chatController.stream.map((message) => Message(
          text: message,
        ));

    _responseStream = _stub.chat(messageStream);
    return _responseStream;
  }

  send(String message) {
    try {
      _chatController.add(message.trim());
    } catch (e) {
      print(e);
    }
  }

  close() {
    _responseStream.cancel();
  }
}
