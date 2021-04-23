import 'dart:ui';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';


class CheckFaceDialog extends StatefulWidget {
  final String title, description, text;
  final String imgPth;

  static const double padding = 20;
  static const double avatarRadius = 45;

  CheckFaceDialog({ Key key, this.title, this.description, this.text, this.imgPth }) : super(key: key);

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

  static const String correctResultName = 'Face Detection';
  static const double correctResultConfidence = 50;


  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    isProcessing = true;
    var resultLoad = await Tflite.loadModel(
        labels: 'assets/labels.txt', model: 'assets/model_unquant.tflite');
    print('result: $resultLoad');
    applyModelOnImage(widget.imgPth);
  }

  applyModelOnImage(imgPth) async {
    var resultRun = await Tflite.runModelOnImage(
        path: imgPth,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5
    );

    setState(() {
      _resultModel = resultRun;
      String str = _resultModel[0]['label'];
      _nameModel = str.substring(2);
      _confidence = _resultModel != null ? (_resultModel[0]['confidence'] * 100.0) : 0;
      _confidenceModel = _resultModel != null
          ? (_resultModel[0]['confidence'] * 100.0).toString().substring(0, 2) + '%'
          : '';
      print('$_nameModel, $_confidenceModel');
      if (_nameModel == correctResultName && _confidence > correctResultConfidence) {
        isValidPhoto = true;
      } else {
        isValidPhoto = false;
      }
      isProcessing = false;
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
          padding: EdgeInsets.only(
            left: CheckFaceDialog.padding,
            top: CheckFaceDialog.avatarRadius + CheckFaceDialog.padding,
            right: CheckFaceDialog.padding,
            bottom: CheckFaceDialog.padding
          ),
          margin: EdgeInsets.only(top: CheckFaceDialog.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(CheckFaceDialog.padding),
            boxShadow: [
              BoxShadow(color: Colors.black,offset: Offset(0,10),
              blurRadius: 10
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: Image.file(
                    File(widget.imgPth),
                    height: 100.0,
                    width: 100.0,
                    fit: BoxFit.cover,
                  ),
              ),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context, 'success');
                    },
                    child: Text(widget.text, style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
        Positioned(
          left: CheckFaceDialog.padding,
            right: CheckFaceDialog.padding,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: CheckFaceDialog.avatarRadius,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(CheckFaceDialog.avatarRadius)),
                  child: isProcessing
                    ? Center(child: CircularProgressIndicator())
                    : _confidence > 50
                    ? Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 20,
                      )
                    : Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                        size: 20,
                      )
              ),
            ),
        ),
      ],
    );
  }
}