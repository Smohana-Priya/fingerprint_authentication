// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final LocalAuthentication auth;

  // bool supportState = false;

  @override
  void initState() {
    super.initState();

    auth = LocalAuthentication();
    // auth.isDeviceSupported().then((bool isSupported) => setState(() {
    //       supportState = isSupported;
    //     }));
  }

  // Future<void> _getAvailableBioMetrics() async {
  //   List<BiometricType> availableBiometrics =
  //       await auth.getAvailableBiometrics();

  //   if (!mounted) {
  //     return;
  //   }
  // }

  Future<void> _authenticate(BuildContext context) async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: "Scan your fingerprint to authenticate",
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: true));
      if (authenticated) {
        print("authenticated-----$authenticated");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              "Login",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            Lottie.asset("assets/animation.json", height: 200),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Fingerprint Auth",
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 5),
              child: Center(
                child: Text(
                  "Authenticate using fingerprint to proceed in application",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            //get available bio metrics type
            // ElevatedButton(
            //     onPressed: _getAvailableBioMetrics,
            //     child: const Text("Get available biometrics")),

            ElevatedButton(
                onPressed: () {
                  _authenticate(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Authenticate",
                    style: TextStyle(fontSize: 20),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
