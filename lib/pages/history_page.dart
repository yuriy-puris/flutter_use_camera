import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('History', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            HistoryList()
          ],
        ),
      )
    );
  }
}


class HistoryList extends StatelessWidget {

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple[900],
            Colors.black,
          ],
        )),
      child: Scrollbar( 
        child: ListView.builder(
          itemCount: 40,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Row(
              children: <Widget>[
                Text('Name'),
                Text('Price'),
                Text('Icon')
              ],
            );
          }
        ),
      ),
    );
  }
}

class HistoryItem {
  const HistoryItem(this.name, this.count, this.price, this.date);
  final String name;
  final int count;
  final double price;
  final String date;
}