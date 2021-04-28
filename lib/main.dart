import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_use_camera/model/user.dart';
import 'package:flutter_use_camera/components/user.dart';
import 'package:flutter_use_camera/pages/home_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => User(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen(),
        ));
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 4),
        () => {
              // Navigator.pushNamed(context, '/home')
              Navigator.of(context).pushAndRemoveUntil<dynamic>(
                  MaterialPageRoute<dynamic>(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false),
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple[900],
            Colors.black,
          ],
        )),
        child: Center(
            child: SizedBox(
          width: 250.0,
          child: TypewriterAnimatedTextKit(
            isRepeatingAnimation: false,
            speed: const Duration(milliseconds: 60),
            text: [
              "Itera Research",
            ],
            textStyle: TextStyle(
                color: Colors.white, fontSize: 35.0, fontFamily: "Agne"),
            textAlign: TextAlign.center,
          ),
        )),
      ),
    );
  }
}
