import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc_chat/src/web_dummy.dart';

ClientChannelBase getClientChannel() {
  return GrpcWebClientChannel.xhr(
    Uri.parse('http://localhost:8080'),
  );
}
