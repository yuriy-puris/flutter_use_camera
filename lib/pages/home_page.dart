import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_use_camera/model/user.dart';
import 'package:flutter_use_camera/pages/registration_page.dart';
import 'package:flutter_use_camera/pages/product_page.dart';

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
    // Future.delayed(Duration.zero, () {
    //   Navigator.of(context).pushAndRemoveUntil<dynamic>(
    //         MaterialPageRoute<dynamic>(
    //           builder: (context) => RegisterPage()
    //         ),
    //         (Route<dynamic> route) => false
    //       );
    // });
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    // var menu_snack_uri = AssetImage('assets/images/snack.png');
    // var menu_snack_image = Image(image: menu_snack_uri, height: 140.0);
    // var menu_water_uri = AssetImage('assets/images/fastfood.png');
    // var menu_water_image = Image(image: menu_water_uri, height: 140.0);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Dashboard', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                    child: Icon(
                      Icons.app_registration,
                      color: Colors.white,
                    ),
                  ),
                  Text('Sign Up')
                ],
              ),
            ),
          ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 100, 15, 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple[900],
              Colors.black,
            ],
          )
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 64,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.indigo[400],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hello,',
                        style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600)
                      ),
                      Text(
                        'Test user',
                        style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600)
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductPage('Snack'))
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.indigo[400],
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            width: 120.0,
                            height: 120.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image(image: AssetImage(
                                  'assets/images/snack.png'
                                ),
                                height: 60.0,
                                ),
                                Text(
                                  'Snack',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w300
                                  ),
                                )
                              ],
                            )
                          ),
                        )
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo[400], 
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          width: 120.0,
                          height: 120.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image(image: AssetImage(
                                'assets/images/fastfood.png'
                              ),
                              height: 60.0,
                              ),
                              Text(
                                'Water',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w300
                                ),
                              )
                            ],
                          )
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
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