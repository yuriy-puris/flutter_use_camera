import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter_use_camera/pages/registration_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisibleAppBar = false;

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
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: isVisibleAppBar 
            ? AppBar(
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
            )
            : null,
        body: Container(
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                      child: Container(
                    padding: EdgeInsets.fromLTRB(15, (isVisibleAppBar ? 60 : 10), 15, 15),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.deepPurple[900],
                        Colors.black,
                      ],
                    )),
                    child: Column(
                      children: <Widget>[
                        TimeBar(),
                        ProfileHeadBar(),
                        PurchaseBar.withSampleData(),
                        LatestTransactionsBar(),
                      ],
                    ),
                  ))),
            );
          }),
        ));
  }
}

// TimeBar Component
class TimeBar extends StatefulWidget {
  @override
  _TimeBarState createState() => _TimeBarState();
}

class _TimeBarState extends State<TimeBar> {
  String _dateString;
  String _timeString;
  var timer;

  @override
  void initState() {
    super.initState();
    _runTime();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void _runTime() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    final String formattedDate =
        DateFormat('EEEEEE dd').format(DateTime.now()).toString();
    final String formattedTime =
        DateFormat('kk:mm').format(DateTime.now()).toString();
    setState(() {
      _dateString = formattedDate;
      _timeString = formattedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Center(
            child: Column(
          children: <Widget>[
            Text(
              _dateString.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              _timeString.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ],
        )));
  }
}

class ProfileHeadBar extends StatefulWidget {
  @override
  _ProfileHeadBarState createState() => _ProfileHeadBarState();
}

class _ProfileHeadBarState extends State<ProfileHeadBar> {
  String name = 'Test User';
  String position = 'Mobile Developer';
  String avatar = 'Test User';
  bool isEditing = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _positionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _nameController.value = TextEditingValue(text: name);
      _nameController.value = TextEditingValue(text: position);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setEditing() {
    setState(() {
      isEditing = true;
    });
  }

  _formEditing() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              onChanged: (val) {
                name = val;
              },
              controller: _nameController,
              validator: (value) {
                return value.isNotEmpty ? null : 'Invalid Field';
              },
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white, width: 1.0),
                ),
                hintText: 'Enter username',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
                  contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                  errorStyle: TextStyle(
                    fontSize: 10,
                  ),
              ),
            ),
            TextFormField(
              onChanged: (val) {
                position = val;
              },
              controller: _positionController,
              validator: (value) {
                return value.isNotEmpty ? null : 'Invalid Field';
              },
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white, width: 1.0),
                ),
                hintText: 'Enter position',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
                  contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  errorStyle: TextStyle(
                    fontSize: 10,
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveUser() {
    setState(() {
      isEditing = false;
      // name = nameController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      margin: EdgeInsets.only(bottom: 50.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromRGBO(68, 15, 192, 1.0),
      ),
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: Container(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.indigo[400],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Text(
                              _nameController.text,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                            ),
                          Text(
                            _positionController.text,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w300)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Center(
                          child: !isEditing ? InkWell(
                                  onTap: () async {
                                    setState(() {
                                      isEditing = true;
                                    });
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(23, 30, 92, 0.6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.edit_rounded,
                                        color: Colors.white,
                                        size: 23,
                                      )),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (_formKey.currentState.validate()) {
                                        isEditing = false;
                                      }
                                    });
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(23, 30, 92, 0.6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close_sharp,
                                        color: Colors.white,
                                        size: 23,
                                      )),
                                )),
                    ],
                  ),
                ],
              ),
              if (isEditing) Positioned(
                top: 0,
                width: 200,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromRGBO(68, 15, 192, 1.0),
                      ),
                      child: _formEditing()
                    ),
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}

class PurchaseBar extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PurchaseBar(this.seriesList, {this.animate});

  String title = 'Purchases';
  double totalBalance = 333.5;
  String currency = '0x20B4';

  factory PurchaseBar.withSampleData() {
    return new PurchaseBar(
      _createSampleData(),
      animate: true,
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final globalSalesData = [
      new OrdinalSales('2011', 3200),
      new OrdinalSales('2013', 4400),
      new OrdinalSales('2014', 5000),
      new OrdinalSales('2015', 5000),
      new OrdinalSales('2016', 4500),
      new OrdinalSales('2017', 4300),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Purchase',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: globalSalesData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150.0,
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          margin: EdgeInsets.only(bottom: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color.fromRGBO(23, 30, 92, 1.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text('Last 6 months',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w300)),
                    ),
                    Container(
                      child: Text('₴ 12.000',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: SizedBox(
                  width: 150.0,
                  height: 70.0,
                  child: new charts.BarChart(
                    seriesList,
                    animate: animate,
                    barGroupingType: charts.BarGroupingType.grouped,
                    primaryMeasureAxis: new charts.NumericAxisSpec(
                        renderSpec: new charts.NoneRenderSpec()),
                    secondaryMeasureAxis: new charts.NumericAxisSpec(
                        tickProviderSpec:
                            new charts.BasicNumericTickProviderSpec(
                                desiredTickCount: 3)),
                    domainAxis: new charts.OrdinalAxisSpec(
                        showAxisLine: true,
                        renderSpec: new charts.NoneRenderSpec()),
                    layoutConfig: new charts.LayoutConfig(
                        leftMarginSpec: new charts.MarginSpec.fixedPixel(0),
                        topMarginSpec: new charts.MarginSpec.fixedPixel(0),
                        rightMarginSpec: new charts.MarginSpec.fixedPixel(0),
                        bottomMarginSpec: new charts.MarginSpec.fixedPixel(0)),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class LatestTransactionsBar extends StatelessWidget {
  final dataTransactions = [
    Transaction('Snickers', '28.04.2021', '₴ 11.50'),
    Transaction('Nuts', '26.04.2021', '₴ 13.00'),
    Transaction('Chocolate', '25.04.2021', '₴ 22.00'),
    Transaction('Kit-Kat', '24.04.2021', '₴ 10.00'),
  ];

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      margin: EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromRGBO(23, 30, 92, 1.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Latest transactions',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
                Icon(
                  Icons.payment_rounded,
                  color: Color.fromRGBO(83, 91, 166, 1.0),
                )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              ...dataTransactions.map((item) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300)),
                          Text(item.date,
                              style: TextStyle(
                                  color: Color.fromRGBO(200, 201, 216, 1.0),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w200)),
                        ],
                      ),
                      Text(item.price,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                );
              }).toList(),
            ],
          )
        ],
      ),
    );
  }
}

class Transaction {
  final String name;
  final String date;
  final String price;

  Transaction(this.name, this.date, this.price);
}
