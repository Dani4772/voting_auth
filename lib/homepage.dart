import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class TouchID extends StatefulWidget {
  const TouchID({Key? key}) : super(key: key);

  @override
  _TouchIDState createState() => _TouchIDState();
}

class _TouchIDState extends State<TouchID> {
  final LocalAuthentication localAuth = LocalAuthentication();
  String _authorizeText = 'Not Authorized!';

  Future<void> _authorize() async {
    bool _isAuthorized = false;
    try {
      _isAuthorized = await localAuth.authenticate(
        localizedReason: 'Please authenticate to Complete this process',
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;
    setState(() {
      if (_isAuthorized) {
        _authorizeText = "Authorized Successfully!";
      } else {
        _authorizeText = "Not Authorized!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voting'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _authorizeText,
                  style: const TextStyle(color: Colors.black38, fontSize: 20),
                ),
              ),
              ElevatedButton(
                child: const Text(
                  'Authorize',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: _authorize,
              )
            ],
          )),
    );
  }
}