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
      "id": 7,
      "email": "michael.lawson@reqres.in",
      "first_name": "Michael",
      "last_name": "Lawson",
    },
    {
      "id": 8,
      "email": "lindsay.ferguson@reqres.in",
      "first_name": "Lindsay",
      "last_name": "Ferguson",
    },
    {
      "id": 9,
      "email": "tobias.funke@reqres.in",
      "first_name": "Tobias",
      "last_name": "Funke",
    }
  ];

  Future<void> getData() async {
    await Future.delayed(Duration(seconds: 3));
    return data;
  }

  Widget _buildTable(List<Map<String, dynamic>> data) {

    var rows = data
      .map((e) => TableRow(
        children: e.entries.map((e) {
          Widget child;
          child = Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '${e.value}',
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          );
          return TableCell(child: child);
        }).toList()
      ))
      .toList();

    rows.insert(
      0,
      TableRow(
        children: data.first.entries.map((e) =>
          TableCell(
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(12),
                child: Text(
                  '${e.key.mayusculas}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ).toList()
      )
    );


    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(
        color: Colors.white38, 
        width: 1, 
        style: BorderStyle.solid
      ),
      columnWidths: {
        0: IntrinsicColumnWidth(),
      },
      // defaultColumnWidth: FractionColumnWidth(.1),
      // defaultColumnWidth: FixedColumnWidth(100),
      defaultColumnWidth: FlexColumnWidth(),
      children: rows,
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
