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

// Using .value constructor to access provider in anonymous route access(Dynamic routes without a route name)
// When using MaterialPageRoute, it becomes a child of MaterialApp and a sibling of ChangeNotifierProvider, making it unable to be found by Provider.of.
// This is where the ChangeNotifierProvider.value constructor is used. It is used when providing an already existing provider in a new subtree. The .value constructor does not automatically close the class.
// In this case, the context of the Navigator.push and the MaterialPageRoute overlap. The context of MaterialPageRoute is unrelated to the Navigator context, making it impossible to find. To use the higher context, you need to rename the name of the lower context.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Route',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<Counter>(
        create: (context) => Counter(),
        child: const MyHomePage(),
      ),
    );
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