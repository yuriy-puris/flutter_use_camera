import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_use_camera/model/user.dart';
import 'package:flutter_use_camera/components/user.dart';

class UserLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    print(user.name == null);
    return context.watch<User>().name == ''
        ? RaisedButton(
        onPressed: () => Provider.of<User>(context, listen: false).updateUserName('Yuriy'),
        child: Text('Войти')
    ) : RaisedButton(
        onPressed: () => Provider.of<User>(context, listen: false).updateUserName(''),
        child: Text('Выйти')
    );
  }
}