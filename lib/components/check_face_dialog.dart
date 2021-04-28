import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class CheckFaceDialog extends StatefulWidget {
  final String title, description, text;
  final String imgPth;

  static const double padding = 10;
  static const double avatarRadius = 45;

  CheckFaceDialog(
      {Key key, this.title, this.description, this.text, this.imgPth})
      : super(key: key);

  @override
  _CheckFaceDialogState createState() => _CheckFaceDialogState();
}

class _CheckFaceDialogState extends State<CheckFaceDialog> {
  bool isProcessing = false;
  List _resultModel;
  double _confidence;
  String _confidenceModel = '';
  String _nameModel = '';
  String numbersModel = '';
  bool isValidPhoto = false;

  List<Map<String, int>> faceMaps = [];

  static const String correctResultName = 'Real Face';
  static const double correctResultConfidence = 50;

  @override
  void initState() {
    super.initState();
    applyModelOnImage(widget.imgPth);
  }

  applyModelOnImage(imgPth) async {
    var resultRun = await Tflite.runModelOnImage(
        path: imgPth,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _resultModel = resultRun;
      print('$resultRun');
      String str = _resultModel[0]['label'];
      _nameModel = str.substring(2);
      _confidence =
          _resultModel != null ? (_resultModel[0]['confidence'] * 100.0) : 0;
      _confidenceModel = _resultModel != null
          ? (_resultModel[0]['confidence'] * 100.0).toString().substring(0, 2) +
              '%'
          : '';

      if (_nameModel == correctResultName &&
          _confidence > correctResultConfidence) {
        isValidPhoto = true;
      } else {
        isValidPhoto = false;
      }

      isProcessing = false;
      // closePopup(isValidPhoto);
    });
  }

  closePopup(bool valid) {
    Future.delayed(const Duration(milliseconds: 4000), () {
      Navigator.pop(context, valid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CheckFaceDialog.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 300,
          padding: EdgeInsets.only(
              left: CheckFaceDialog.padding,
              top: CheckFaceDialog.avatarRadius + CheckFaceDialog.padding,
              right: CheckFaceDialog.padding,
              bottom: CheckFaceDialog.padding),
          margin: EdgeInsets.only(top: CheckFaceDialog.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.indigo[400],
              borderRadius: BorderRadius.circular(CheckFaceDialog.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                isProcessing ? widget.title : 'Checked photo',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Image.file(
                  File(widget.imgPth),
                  height: 120.0,
                  width: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                isValidPhoto ? 'Real Face' : 'Fake Face',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      widget.text,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: CheckFaceDialog.padding,
          right: CheckFaceDialog.padding,
          child: CircleAvatar(
            backgroundColor: Colors.indigo[400],
            radius: CheckFaceDialog.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(CheckFaceDialog.avatarRadius)),
                child: isProcessing
                    ? Center(child: CircularProgressIndicator())
                    : isValidPhoto
                        ? Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 50,
                          )
                        : Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                            size: 50,
                          )),
          ),
        ),
      ],
    );
  }
}
