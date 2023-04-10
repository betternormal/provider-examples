import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ConsumerExample());
}


class Dog with ChangeNotifier{
  final String name;
  final String breed;
  int age;
  Dog({
    required this.name,
    required this.breed,
    this.age = 1,
  });

  void grow() {
    age++;
    print('age: $age');
    notifyListeners();
  }
}

// Consumer widget finds the corresponding provider type and passes it as a parameter to the builder method.
// Consumer widget doesn't perform any complicated tasks. It simply calls Provider.of in a new widget and delegates the build implementation to the builder.
// Widgets set in the 'child' parameter are not rebuilt even if they are within the Consumer widget.
class ConsumerExample extends StatelessWidget {
  const ConsumerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Dog>(
      create: (context) => Dog(name: 'dog04', breed: 'breed04', age: 5),
      child: MaterialApp(
        title: 'Provider 04',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider 04'),
      ),
      body: Consumer<Dog>(
        builder: (BuildContext context,Dog dog, Widget? child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '- name: ${dog.name}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
                BreedAndAge(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Dog>(
        builder: (_, Dog dog, __) {
          return Column(
            children: [
              Text(
                '- breed: ${dog.breed}',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Age(),
            ],
          );
        }
    );
  }
}

class Age extends StatelessWidget {
  const Age({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Dog>(
      builder: (_, Dog dog, Widget? ignore) {
        return Column(
          children: [
            Text(
              '- age: ${dog.age}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => dog.grow(),
              child: ignore,
            ),
          ],
        );
      },
      child: Text(
      'Grow',
      style: TextStyle(fontSize: 20.0),
    ),
    );
  }
}