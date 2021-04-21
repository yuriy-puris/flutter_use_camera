import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  String _username, _email, _password;

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
          style: TextStyle(fontSize: 18, color: Colors.white),
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
    return Scaffold(
        // appBar: AppBar(
        //   leading: BackButton(
        //     color: Colors.white
        //   ),
        //   title: Text(
        //     'Sign Up',
        //     style: TextStyle(
        //         color: Colors.white
        //     )
        //   )
        // ),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
              child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
            _showTitle(),
            _showUsernameInput(),
          ]))))));
  }
}
