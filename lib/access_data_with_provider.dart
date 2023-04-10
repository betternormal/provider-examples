import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AccessDataWithProvider());
}

class Dog {
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
  }
}

class AccessDataWithProvider extends StatelessWidget {
  const AccessDataWithProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Since the provider itself is also a widget, children of the provider widget can access the object returned by the create() method.
    // Provider.of<T>() is used to access the object.
    return Provider<Dog>(
      create: (context) => Dog(
        name: 'Sun',
        breed: 'Bulldog',
        age: 3,
      ),
      child: MaterialApp(
        title: 'Provider 02',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider 02'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '- name: ${Provider.of<Dog>(context).name}',
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
  const BreedAndAge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- breed: ${Provider.of<Dog>(context).breed}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 10.0),
        Age(),
      ],
    );
  }
}

class Age extends StatelessWidget {
  const Age({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- age: ${Provider.of<Dog>(context).age}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () => Provider.of<Dog>(context, listen: false).grow(),
          child: Text(
            'Grow',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ],
    );
  }
}