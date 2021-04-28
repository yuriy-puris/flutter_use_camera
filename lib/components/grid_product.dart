import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridProduct extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             ProductPage('Snack')));
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
                            Image(
                              image: AssetImage('assets/images/snack.png'),
                              height: 60.0,
                            ),
                            Text(
                              'Snack',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        )),
                  )),
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
                        Image(
                          image: AssetImage('assets/images/fastfood.png'),
                          height: 60.0,
                        ),
                        Text(
                          'Water',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
