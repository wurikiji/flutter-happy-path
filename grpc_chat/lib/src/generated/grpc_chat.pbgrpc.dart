///
//  Generated code. Do not modify.
//  source: grpc_chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'grpc_chat.pb.dart' as $0;
export 'grpc_chat.pb.dart';

class GrpcChatClient extends $grpc.Client {
  static final _$chat = $grpc.ClientMethod<$0.Message, $0.Message>(
      '/grpc_chat.GrpcChat/Chat',
      ($0.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));

  GrpcChatClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.Message> chat($async.Stream<$0.Message> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$chat, request, options: options);
  }
}

abstract class GrpcChatServiceBase extends $grpc.Service {
  $core.String get $name => 'grpc_chat.GrpcChat';

  GrpcChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Message, $0.Message>(
        'Chat',
        chat,
        true,
        true,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
  }

  $async.Stream<$0.Message> chat(
      $grpc.ServiceCall call, $async.Stream<$0.Message> request);
}
