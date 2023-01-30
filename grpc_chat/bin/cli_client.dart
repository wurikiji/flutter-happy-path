import 'dart:convert';
import 'dart:io';

import 'package:grpc_chat/src/client.dart';

Future main() async {
  final client = ChatClient();
  final stream = client.connect();
  stream.listen((message) {
    print('Got message: ${message.text}');
  });
  await for (final input in stdin.transform(const Utf8Decoder())) {
    print("\rSend $input");
    client.send(input);
    await client.close();
  }
}
