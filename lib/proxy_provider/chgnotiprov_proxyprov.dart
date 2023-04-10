import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

class Translations {
  const Translations(this._value);
  final int _value;

  String get title => 'You clicked $_value times';
}

// Combining ChangeNotifierProvider and ProxyProvider is the best way. It creates new instance, which is the preferred way.
class ChgNotiProvProxyProv extends StatefulWidget {
  const ChgNotiProvProxyProv({Key? key}) : super(key: key);

  @override
  _ChgNotiProvProxyProvState createState() => _ChgNotiProvProxyProvState();
}

class _ChgNotiProvProxyProvState extends State<ChgNotiProvProxyProv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChangeNotifierProvider ProxyProvider'),
      ),
      body: Center(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<Counter>(
              create: (_) => Counter(),
            ),
            ProxyProvider<Counter, Translations>(
              update: (_, counter, __) => Translations(counter.counter),
            ),
          ],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTranslations(),
              SizedBox(height: 20.0),
              IncreaseButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowTranslations extends StatelessWidget {
  const ShowTranslations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = context.watch<Translations>().title;

    return Text(
      title,
      style: TextStyle(fontSize: 28.0),
    );
  }
}

class IncreaseButton extends StatelessWidget {
  const IncreaseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.read<Counter>().increment(),
      child: Text(
        'INCREASE',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}