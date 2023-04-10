import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class Counter with ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

void main() {
  runApp(const MyApp());
}


// To provide an existing counter provider to two routes, declare the counter state inside the widget and inject it to named routes with `ChangeNotifierProvider.value`.
// Since the counter `ChangeNotifier` was not created with `ChangeNotifierProvider`, it needs to be manually disposed.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Counter _counter = Counter();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Route',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => ChangeNotifierProvider.value(
          value: _counter,
          child: const MyHomePage(),
        ),
        '/counter': (context) => ChangeNotifierProvider.value(
          value: _counter,
          child: const ShowMeCounter(),
        ),
      },
    );
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text(
                'Show Me Counter',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return ChangeNotifierProvider.value(
                      value: context.read<Counter>(),
                      child: ShowMeCounter(),
                    );
                  }),
                );
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text(
                'Increment Counter',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                context.read<Counter>().increment();
              },
            )
          ],
        ),
      ),
    );
  }
}


class ShowMeCounter extends StatelessWidget {
  const ShowMeCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Center(
        child: Text(
          '${context.watch<Counter>().counter}',
          style: TextStyle(fontSize: 52.0),
        ),
      ),
    );
  }
}