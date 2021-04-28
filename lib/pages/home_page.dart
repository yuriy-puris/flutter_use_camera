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
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                      child: Container(
                    padding: EdgeInsets.fromLTRB(15, 60, 15, 15),
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

  @override
  void initState() {
    super.initState();
    _getTime();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    final String formattedDate =
        DateFormat('EEEEEE dd').format(DateTime.now()).toString();
    final String formattedTime =
        DateFormat('kk:mm').format(DateTime.now()).toString();
    setState(() {
      _dateString = formattedDate;
      _timeString = formattedTime;
      print(_timeString);
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

  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  @override
  void initState() {
    super.initState();
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

  void saveUser() {
    setState(() {
      isEditing = false;
      name = nameController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      margin: EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromRGBO(68, 15, 192, 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.indigo[400],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: 200.0,
                      height: 30,
                      child: isEditing
                          ? Container(
                              margin: EdgeInsets.only(top: 10.0),
                              child: TextField(
                                onChanged: (val) {
                                  name = val;
                                },
                                controller: nameController,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  hintText: 'Enter your name',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          : Container(
                              child: Text(name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            )),
                  SizedBox(
                    width: 200,
                    height: 30,
                    child: isEditing
                        ? Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: TextField(
                              onChanged: (val) {
                                position = val;
                              },
                              controller: positionController,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                hintText: 'Enter your position',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        : Text(position,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w300)),
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Center(
                  child: !isEditing
                      ? InkWell(
                          onTap: () {
                            setEditing();
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
                            saveUser();
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
          )
        ],
      ),
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
