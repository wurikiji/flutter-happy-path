import 'dart:isolate';

main() async {
  for (int i = 0; i < 20; ++i) {
    Isolate.spawn(logAfterLoop, i);
  }
  print("Loop done");
}

logAfterLoop(int index) async {
  for (int i = 0; i < 1000; ++i) {}
  print("Hello $index");
}

predictableAsync() async {}
