import 'package:flutter/material.dart';

import 'chgnotiprov_chgnotiproxyprov.dart';
import 'chgnotiprov_proxyprov.dart';
import 'proxyprov_create_update.dart';
import 'proxyprov_proxyprov.dart';
import 'proxyprov_update.dart';
import 'why_proxyprov.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProxyProvider Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ElevatedButton(
                child: Text(
                  'Why\nProxyProvider',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WhyProxyProv(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'ProxyProvider\nupdate',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProxyProvUpdate(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'ProxyProvider\ncreate/update',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProxyProvCreateUpdate(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'ProxyProvider\nProxyProvider',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProxyProvProxyProv(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'ChangeNotifierProvider\nChangeNotifierProxyProvider',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChgNotiProvChgNotiProxyProv(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'ChangeNotifierProvider\nProxyProvider',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChgNotiProvProxyProv(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}