import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/grpc_web.dart';

ClientChannelBase getClientChannel() {
  return GrpcWebClientChannel.xhr(
    Uri.parse('http://localhost:8080'),
  );
}
