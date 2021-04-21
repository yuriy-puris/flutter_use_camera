import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_use_camera/model/user.dart';
import 'package:flutter_use_camera/pages/registration_page.dart';
import 'package:flutter_use_camera/pages/login_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container()
  //   );
  // }
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil<dynamic>(
            MaterialPageRoute<dynamic>(
              builder: (context) => RegisterPage()
            ),
            (Route<dynamic> route) => false
          );
    });
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container()
    );
  }
}


class UserBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        color: Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
        child: Center(child: UserView())
    );
  }
}

class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return user == null ? Container() : Container(
        color: Colors.blueGrey,
        padding: EdgeInsets.all(12.0),
        child: Text(
            "Привет, ${user.name}!",
            style: TextStyle(color: Colors.white)
        )
    );
  }
}