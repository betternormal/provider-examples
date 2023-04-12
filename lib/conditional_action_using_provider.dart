import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum AppState {
  initial,
  loading,
  success,
  error,
}


// The first approach is handling the submit method, use async await to receive the result and then display the navigation or dialog. If there is an error, it should be rethrown from the provider so that it can be handled from the submit method. This approach might not clearly separate the business logic and UI.
// The second approach is a way to display navigation or dialogues depending on the app state in the build() of the UI. However, since build() is executed more often than expected, a dialogue is displayed in unnecessary situations. and It should be executed in addPostFrameCallback since it is executed within the build method.
// The third approach is displaying navigation and dialogs within the provider's method. Since it requires context, the provider needs to share context, which mixes UI and business logic.
// The fourth approach is to use ChangeNotifier to register a void callback that listens when notifyListener() is executed and displays navigation and dialog. Since it is not automatically released, it must be manually disposed of. Also, be careful as the listener may be executed by other elements.
// First and fourth methods are preferred.

class AppProvider with ChangeNotifier {
  AppState _state = AppState.initial;
  AppState get state => _state;

  Future<void> getResult(String searchTerm) async {
    _state = AppState.loading;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    try {
      if (searchTerm == 'fail') {
        throw 'Something went wrong';
      }

      _state = AppState.success;
      notifyListeners();
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (context) {
      //     return SuccessPage();
      //   },
      // ));
    } catch (e) {
      _state = AppState.error;
      notifyListeners();
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       content: Text('Something went wrong'),
      //     );
      //   },
      // );
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (_) => AppProvider(),
      child: MaterialApp(
        title: 'addListener of ChangeNotifier',
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? searchTerm;
  late final AppProvider appProv;

  @override
  void initState() {
    super.initState();
    appProv = context.read<AppProvider>();
    appProv.addListener(appListener);
  }

  void appListener() {
    if (appProv.state == AppState.success) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return SuccessPage();
        },
      ));
    } else if (appProv.state == AppState.error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Something went wrong'),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    appProv.removeListener(appListener);
    super.dispose();
  }

  void submit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    final form = formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    context.read<AppProvider>().getResult(searchTerm!);
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (context) {
    //     return SuccessPage();
    //   },
    // ));

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       content: Text('Something went wrong'),
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppProvider>().state;

    // if (appState == AppState.success) {
    //   WidgetsBinding.instance!.addPostFrameCallback((_) {
    //     Navigator.push(context, MaterialPageRoute(
    //       builder: (context) {
    //         return SuccessPage();
    //       },
    //     ));
    //   });
    // } else if (appState == AppState.error) {
    //   WidgetsBinding.instance!.addPostFrameCallback((_) {
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           content: Text('Something went wrong'),
    //         );
    //       },
    //     );
    //   });
    // }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Search'),
                      prefixIcon: Icon(Icons.search),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Search term required';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      searchTerm = value;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    child: Text(
                      appState == AppState.loading
                          ? 'Loading...'
                          : 'Get Result',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    onPressed: appState == AppState.loading ? null : submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Text(
          'Success',
          style: TextStyle(fontSize: 48.0),
        ),
      ),
    );
  }
}