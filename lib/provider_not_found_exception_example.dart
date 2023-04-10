import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ProviderNotFoundExceptionExample());
}

class ProviderNotFoundExceptionExample extends StatelessWidget {
  const ProviderNotFoundExceptionExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider 09',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class Foo with ChangeNotifier {
  String value = 'Foo';

  void changeValue() {
    value = value == 'Foo' ? 'Bar' : 'Foo';
    notifyListeners();
  }
}

// When receiving the upper context as a parameter, it cannot be found because it searches for the provider above it. In this case, you need to create a lower context using the builder method to access and find it.
// Alternatively, you can extract the widget into a new widget to create a new context.
// Alternatively, Builder() can be used to create a new context.
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);


  // BEFORE
  // @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(
  //         title: Text('Provider 09'),
  //       ),
  //       body: ChangeNotifierProvider<Foo>(
  //         create: (_) => Foo(),
  //         child: Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 '${context.watch<Foo>().value}',
  //                 style: TextStyle(fontSize: 40),
  //               ),
  //               SizedBox(height: 20.0),
  //               ElevatedButton(
  //                 onPressed: () => context.read<Foo>().changeValue(),
  //                 child: Text(
  //                   'Change Value',
  //                   style: TextStyle(fontSize: 20.0),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }

  // AFTER 1:
  // @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       body: Center(
  //         child: ChangeNotifierProvider<Counter>(
  //           create: (_) => Counter(),
  //           child: Builder(
  //             builder: (context) {
  //               return Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     '${context.watch<Counter>().counter}',
  //                     style: TextStyle(fontSize: 48.0),
  //                   ),
  //                   SizedBox(height: 20.0),
  //                   ElevatedButton(
  //                     child: Text(
  //                       'Increment',
  //                       style: TextStyle(fontSize: 20.0),
  //                     ),
  //                     onPressed: () {
  //                       context.read<Counter>().increment();
  //                     },
  //                   )
  //                 ],
  //               );
  //             },
  //           ),
  //         ),
  //       ),
  //     );
  //   }

  // AFTER 2
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider 09'),
      ),
      body: ChangeNotifierProvider<Foo>(
        create: (_) => Foo(),
        child: Consumer(
          builder: (context, Foo foo, _) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${foo.value}',
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => foo.changeValue(),
                    child: Text(
                      'Change Value',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }



}
