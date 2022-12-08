import 'dart:async';

Future main() async {
  final a = StreamController<int>();
  final stream = a.stream;

  dynamicallyAddDataToStream(a.sink);

  await for (final data in stream) {
    print(data);
  }
}

dynamicallyAddDataToStream(Sink sink) async {
  for (int i = 0; i < 10000; ++i) {
    await Future.delayed(const Duration(milliseconds: 500));
    sink.add(i);
  }
}

Stream<int> pureStream() async* {
  for (int i = 0; i < 10000; ++i) {
    await Future.delayed(const Duration(milliseconds: 500));
    yield i;
  }
}

Future<int> oneTimeAsyncValue() async {
  return 0;
}
