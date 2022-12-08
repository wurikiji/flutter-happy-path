import 'package:grpc/grpc_connection_interface.dart';

class GrpcWebClientChannel extends ClientChannelBase {
  GrpcWebClientChannel.xhr(Uri uri) {
    throw UnimplementedError();
  }

  @override
  ClientConnection createConnection() {
    throw UnimplementedError();
  }
}
