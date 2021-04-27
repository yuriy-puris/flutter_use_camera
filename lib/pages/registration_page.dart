import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_use_camera/components/check_face_dialog.dart';
class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  List images = [];
  bool _obscureText = true;
  String _username, _email, _password;
  int _currentIndex = 0;

  int needUploadPhoto = 5;
  int leastCountPhoto = 5;

  String _confidenceModel = '';
  String _nameModel = '';
  String numbersModel = '';


  @override
  void initState() {
    super.initState();
    images = [];
    loadModel();
  }

  loadModel() async {
    var resultLoad = await Tflite.loadModel(
        labels: 'assets/labels.txt', model: 'assets/model_unquant.tflite');
    print('result: $resultLoad');
  }

  _getFromGallery(context) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      var isValid = await showDialog(
        context: context,
        builder: (_) => CheckFaceDialog(
          title: 'Checking the photo ...',
          description: '',
          text: 'Ok',
          imgPth: pickedFile.path
        )
      );
      if (isValid) {
          setState(() {
            File imageFile = File(pickedFile.path);
            images.add(imageFile);
            updateCountPhoto();
          });
        }
    }
  }

  void updateCountPhoto() {
    print('$leastCountPhoto, $images.length');
    leastCountPhoto = needUploadPhoto - images.length;
  }

  void open(BuildContext context, final int index) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => GalleryPhotoViewWrapper(
    //       galleryItems: galleryItems,
    //       backgroundDecoration: const BoxDecoration(
    //         color: Colors.black,
    //       ),
    //       initialIndex: index,
    //       scrollDirection: verticalGallery ? Axis.vertical : Axis.horizontal,
    //     ),
    //   ),
    // );
  }


  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {},
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed:  () {},
  );


  Widget _showTitle() {
    return Text(
      'Registration', 
      style: TextStyle(fontSize: 35, color: Colors.white),
    );
  }

  Widget _showUsernameInput() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          onSaved: (val) => _username = val,
          style: TextStyle(fontSize: 16, color: Colors.white),
          validator: (val) => val.length < 6 ? 'Username too short' : null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Enter username, min length 6',
              icon: Icon(Icons.face, color: Colors.white))));
  }

  Widget _showFormPreUploadAction() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(children: [
          RaisedButton(
            child: Text('Take photo',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Colors.white)),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              _getFromGallery(context);
            }
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              'You need to upload $leastCountPhoto photos',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          )
        ]));
  }

  Widget _showFormUploadAction() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: RaisedButton(
            child: Text('Upload',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Colors.black)),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              print('upload to server');
            }
          ),
    );
  }

  Widget _showFormActions() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(children: [
          RaisedButton(
              child: Text('Submit',
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.black)),
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: Theme.of(context).primaryColor,
              onPressed: _submit),
          FlatButton(
              child: Text('Existing user? Login'),
              onPressed: () => Navigator.pushReplacementNamed(context, '/login'))
        ]));
  }

  Widget _showGridUploadedPhoto(context) {
    List<Widget> list = List<Widget>();

    for (var i = 0; i < images.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.all(0),
          child: AnimatedContainer(
            alignment: Alignment.center,
            // Use the properties stored in the State class.
            // width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
            // Define how long the animation should take.
            duration: Duration(seconds: 1),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.fastOutSlowIn,
            child: Stack(
              children: [
                Image.file(
                  images[i],
                  height: 180.0,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: -10.0,
                  right: -10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: new IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline, 
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete photo'),
                              content: Text('Are you sure you want to delete photo ?'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    setState(() {
                                      images.removeAt(i);
                                      updateCountPhoto();
                                      Navigator.pop(context);
                                    });
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }),
                  ),
                )
              ]
            )
          ),
          // child: Stack(
          //   children: [
          //     Image.file(
          //       images[i],
          //       height: 180.0,
          //       fit: BoxFit.cover,
          //     ),
          //     Positioned(
          //       top: -5.0,
          //       right: -5.0,
          //       child: Padding(
          //         padding: const EdgeInsets.all(0),
          //         child: new IconButton(
          //           icon: Icon(
          //             Icons.remove_circle_outline, 
          //             color: Theme.of(context).primaryColor,
          //           ),
          //           onPressed: () {
          //            showDialog(
          //               context: context,
          //               builder: (BuildContext context) {
          //                 return AlertDialog(
          //                   title: Text('Setting String'),
          //                   content: Text('Setting String'),
          //                   actions: <Widget>[
          //                     FlatButton(
          //                       child: Text('OK'),
          //                       onPressed: () {
          //                         print('index: $i');
          //                         Navigator.pop(context);
          //                       },
          //                     )
          //                   ],
          //                 );
          //               },
          //             );
          //           }),
          //       ),
          //     )
          //   ],
          // )
        )
      );
    }

    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: list
    );
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _registerUser();
    } else {

    }
  }

  void _registerUser() async {
    // http.Response response = await http.post('http://10.0.2.2:1337/auth/local/register', 
    // body: {
    //   "username": _username,
    //   "email": _email,
    //   "password": _password,
    // });
    // final responseData = json.decode(response.body);
    print('Register clicked');
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Delete photo'),
      content: Text('Would you like to delete photo ?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Registration', style: TextStyle(color: Colors.white)),
      ),
        body: Container(
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
          // decoration: BoxDecoration(color: Colors.black),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
              child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
            _showUsernameInput(),
            (needUploadPhoto == images.length)
            ? _showFormUploadAction()
            : _showFormPreUploadAction(),
            _showGridUploadedPhoto(context)
          ]))))));
  }
}