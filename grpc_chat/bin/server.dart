import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc_chat/src/generated/grpc_chat.pbgrpc.dart';

Future main() async {
  final server = Server(
    [ChatService()],
  );
  await server.serve(port: 8080);
  print('Server listening on port ${server.port}...');
}

class BroadCastMessage {
  BroadCastMessage(this.caller, this.message);
  final ServiceCall caller;
  final Message message;
}

class ChatService extends GrpcChatServiceBase {
  final broadCasting = StreamController<BroadCastMessage>.broadcast();
  @override
  Stream<Message> chat(ServiceCall call, Stream<Message> request) async* {
    final broadCastingStream = broadCasting.stream;

    request.listen((message) {
      broadCasting.add(BroadCastMessage(call, message));
    }, onDone: () {}, onError: (_) {}, cancelOnError: true);

    await for (final message in broadCastingStream) {
      // send to client
      if (call != message.caller) {
        yield message.message;
      }
    }
  }
}
