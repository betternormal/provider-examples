import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class Dog with ChangeNotifier {
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
    notifyListeners();
  }
}

class Babies {
  final int age;
  Babies({
    required this.age,
  });

  Future<int> getBabies() async {
    await Future.delayed(Duration(seconds: 3));

    if (age > 1 && age < 5) {
      return 4;
    } else if (age <= 1) {
      return 0;
    } else {
      return 2;
    }
  }

  Stream<String> bark() async* {
    for (int i = 1; i < age; i++) {
      await Future.delayed(Duration(seconds: 2));
      yield 'Bark $i times';
    }
  }
}

void main() {
  runApp(const StreamProviderExample());
}

// Continuous values are supplied through StreamProvider.
// It is used more than FutureProvider for things like Firebase, battery, stock, etc.
// If you use the watch method within the create function, it will throw an error. Read is more appropriate as create is only called once in the lifecycle.
class StreamProviderExample extends StatelessWidget {
  const StreamProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Dog>(
          create: (context) => Dog(name: 'dog07', breed: 'breed07', age: 3),
        ),
        FutureProvider<int>(
          initialData: 0,
          create: (context) {
            final int dogAge = context.read<Dog>().age;
            final babies = Babies(age: dogAge);
            return babies.getBabies();
          },
        ),
        StreamProvider<String>(
          initialData: 'Bark 0 times',
          create: (context) {
            final int dogAge = context.read<Dog>().age;
            final babies = Babies(age: dogAge * 2);
            return babies.bark();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Provider 07',
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
        title: Text('Provider 07'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '- name: ${context.watch<Dog>().name}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            BreedAndAge(),
          ],
        ),
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
    return Column(
      children: [
        Text(
          '- breed: ${context.select<Dog, String>((Dog dog) => dog.breed)}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 10.0),
        Age(),
      ],
    );
  }
}

class Age extends StatelessWidget {
  const Age({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- age: ${context.select<Dog, int>((Dog dog) => dog.age)}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 10.0),
        Text(
          '- number of babies: ${context.read<int>()}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 10.0),
        Text(
          '- ${context.watch<String>()}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () => context.read<Dog>().grow(),
          child: Text(
            'Grow',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ],
    );
  }
}