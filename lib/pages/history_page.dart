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
          title: Text(
            'History',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple[900],
              Colors.black,
            ],
          )),
          child: Stack(
            children: [HistoryList()],
          ),
        ));
  }
}

class HistoryList extends StatefulWidget {

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  static const data = [
    {
      "id": 1,
      "email": "michael.lawson@reqres.in",
      "name": "Michael",
      "cost": 12.50,
    },
    {
      "id": 2,
      "email": "lindsay.ferguson@reqres.in",
      "name": "Lindsay",
      "cost": 16.50,
    },
    {
      "id": 3,
      "email": "tobias.funke@reqres.in",
      "name": "Tobias",
      "cost": 15.10
    },
    {
      "id": 4,
      "email": "tobias.funke@reqres.in",
      "name": "Tobias",
      "cost": 10.00,
    },
    {
      "id": 5,
      "email": "tobias.funke@reqres.in",
      "name": "Tobias",
      "cost": 8.00,
    },
    {
      "id": 6,
      "email": "tobias.funke@reqres.in",
      "name": "Tobias",
      "cost": 7.50,
    }
  ];

  Future<void> getData() async {
    await Future.delayed(Duration(seconds: 3));
    return data;
  }

  Widget _buildTable(List<Map<String, dynamic>> data) {

    // BODY
    var rows = data
      .map((e) => TableRow(
        children: e.entries.map((e) {
          Widget child;
          child = Padding(
            padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
            child: Text(
              '${e.value}',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white
              ),
            ),
          );
          return TableCell(child: child);
        }).toList()
      ))
      .toList();

    // HEADER
    rows.insert(
      0,
      TableRow(
        children: data.first.entries.map((e) =>
          TableCell(
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                child: Text(
                  '${e.key.mayusculas}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ).toList()
      )
    );


    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(0, 7), blurRadius: 10)],
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromRGBO(23, 30, 92, 1.0),
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder(
          horizontalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid),
        ),
        
        columnWidths: {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(1),
          2: IntrinsicColumnWidth(),
          3: IntrinsicColumnWidth(),
        },
        // defaultColumnWidth: FractionColumnWidth(.1),
        // defaultColumnWidth: FixedColumnWidth(100),
        defaultColumnWidth: FlexColumnWidth(),
        children: rows,
      )
    );
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    )),
              ],
            ),
          );
        } else {
          print(snapshot.data);
          List<Map<String, dynamic>> data = List.from(snapshot.data);
          return Center(
            child: _buildTable(data)
          );
        }
      }
    );
  }
}

extension ExtStrings on String {
  get mayusculas => this.replaceAll('_', ' ').toUpperCase();
}

class HistoryItem {
  const HistoryItem(this.name, this.count, this.price, this.date);
  final String name;
  final int count;
  final double price;
  final String date;
}
