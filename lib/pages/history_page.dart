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

class HistoryList extends StatelessWidget {
  List<DataColumn> columns = [
    DataColumn(label: Text('Header A')),
    DataColumn(label: Text('Header B')),
    DataColumn(label: Text('Header C')),
    DataColumn(label: Text('Header D')),
  ];

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
        child: ListView(
          padding: const EdgeInsets.all(2),
          children: [
            PaginatedDataTable(
                horizontalMargin: 10.0,
                columnSpacing: 10.0,
                rowsPerPage: 4,
                columns: columns,
                source: _HistoryDataSource(context))
          ],
        ));
  }
}

class HistoryItem {
  const HistoryItem(this.name, this.count, this.price, this.date);
  final String name;
  final int count;
  final double price;
  final String date;
}

class _HistoryDataRow {
  _HistoryDataRow(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final int valueD;

  bool selected = false;
}

class _HistoryDataSource extends DataTableSource {
  _HistoryDataSource(this.context) {
    _rows = <_HistoryDataRow>[
      _HistoryDataRow('Cell A1', 'CellB1', 'CellC1', 1),
      _HistoryDataRow('Cell A2', 'CellB2', 'CellC2', 2),
      _HistoryDataRow('Cell A3', 'CellB3', 'CellC3', 3),
      _HistoryDataRow('Cell A4', 'CellB4', 'CellC4', 4)
    ];
  }
  final BuildContext context;
  List<_HistoryDataRow> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
        index: index,
        selected: row.selected,
        onSelectChanged: (value) {
          if (row.selected != value) {
            _selectedCount += value ? 1 : -1;
            row.selected = value;
            print('onSelected');
          }
        },
        cells: [
          DataCell(Text(row.valueA)),
          DataCell(Text(row.valueB)),
          DataCell(Text(row.valueC)),
          DataCell(Text(row.valueD.toString())),
        ]);
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
