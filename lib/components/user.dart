import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_use_camera/model/user.dart';


class UserScope extends StatefulWidget {
  const UserScope({Key key, this.child}): assert(child != null), super(key: key);
  final Widget child;
  @override
  UserScopeState createState() => UserScopeState();
}

class UserScopeState extends State<UserScope> {
  User _user;

  set user(User user) {
    setState(() {
      _user = user;
    });
  }

  User get user => _user;

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: _user,
      child: Provider.value(
        value: this,
        child: widget.child,
      ),
    );
  }
}