import 'package:flutter/foundation.dart';
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
  bool _existingUser = false;

  @override
  void initState() {
    final value = box.read('authInfo');
    final existingAuthInfo = value != null ? AuthInfo.fromJson(value) : null;
    setState(() {
      _authInfo = existingAuthInfo;
      _existingUser = _authInfo != null;
    });
    _login();
    super.initState();
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
        child: !_existingUser
            ? Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Motor Starter Demo',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  ContinueOnSonrButton(
                    onSuccess: (ai) => _setAuthInfo(ai),
                    onError: (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    },
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Logging in as ${_authInfo?.address}...',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                    const CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _login() async {
    if (_authInfo == null) {
      throw Exception('AuthInfo was not found');
    }
    await MotorFlutter.to.login(
      password: _authInfo?.password ?? '',
      address: _authInfo?.address ?? '',
      dscKey: _authInfo?.aesDscKey,
      pskKey: _authInfo?.aesPskKey,
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
    });
  }

  void _setAuthInfo(AuthInfo? authInfo) {
    if (authInfo != null) {
      box.write('authInfo', authInfo.writeToJson());
      setState(() {
        _authInfo = authInfo;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
      });
    } else {
      throw Exception('AuthInfo was not passed to save');
    }
  }
}
