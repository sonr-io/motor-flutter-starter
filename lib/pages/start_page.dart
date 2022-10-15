import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motor_flutter/motor_flutter.dart';
import 'package:motor_flutter_starter/pages/dashboard_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final box = GetStorage();
  AuthInfo? _authInfo;

  void _setAuthInfo(AuthInfo? authInfo) {
    if (authInfo != null) {
      box.write('authInfo', authInfo.writeToJson());
      setState(() {
        _authInfo = authInfo;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'Motor Starter Demo',
              style: Theme.of(context).textTheme.headline3,
            ),
            ContinueOnSonrButton(
              onSuccess: (ai) {
                _setAuthInfo(ai);
              },
            ),
            TextButton(
                onPressed: () {
                  final authInfo = box.read('authInfo');
                  if (authInfo != null) {
                    _authInfo = AuthInfo.fromJson(authInfo);
                    MotorFlutter.to.login(
                      password: _authInfo?.password ?? '',
                      address: _authInfo?.address ?? '',
                      dscKey: _authInfo?.aesDscKey,
                      pskKey: _authInfo?.aesPskKey,
                    );
                  } else {
                    throw Exception('No authInfo found');
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                  ),
                ))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
