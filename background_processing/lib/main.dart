import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    print("카운터 증가");
  });
}

main() async {
  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask('haha', 'hoho');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    Isolate.spawn((_) {
      final timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
        print("카운터 증가");
      });
    }, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () async {
            final controller =
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("복잡한 작업 실행 시작."),
              duration: Duration(milliseconds: 500),
            ));
            await compute(complexTask, null);
            if (mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("복잡한 작업 실행 끝.")));
            }
          },
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}

complexTask(_) async {
  int a = 0;
  for (int i = 0; i < 7000000000; ++i) {
    a++;
  }
}
