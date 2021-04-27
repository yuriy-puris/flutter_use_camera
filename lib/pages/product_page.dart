import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ProductPage extends StatefulWidget {
  final String title_page;

  ProductPage(this.title_page);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  void initState() {
    super.initState();
  }

  _getFromGallery(context) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.values[1],
      maxWidth: 1800,
      maxHeight: 1800,
    );
    setState(() {
      // File imageFile = File(pickedFile.path);
      // images.add(imageFile);
      // updateCountPhoto();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(widget.title_page, style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 100, 15, 15),
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                RaisedButton(
                  child: Text(
                    'Take photo',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white
                      )),
                  elevation: 8.0,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    _getFromGallery(context);
                  }
                ),
              ]),
          ),
        )
      ),
    );
  }

}