import 'package:flutter/material.dart';
import 'package:hacker_new/models/user.dart';
import 'package:hacker_new/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {

  BuildContext _ctx;
  bool _isLoading;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _username, _password;

  LoginPagePresenter _presenter;

  _LoginPageState(){
    _presenter = LoginPagePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void onLoginError(String error) {
    _ctx = context;
    var loginBtn = RaisedButton(
      onPressed: _submit,
      child: Text("Login"),
      color: Colors.green,
    );

    var loginForm = Column(
      children: <Widget>[
        Text("Sqflite App Login", textScaleFactor: 2.0,),
        Form(key: formKey, child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10.0),child: TextFormField(
              onSaved: (val),
            ),),
          ],
        ),),
      ],
    )
  }

  @override
  void onLoginSuccess(User user) {
    // TODO: implement onLoginSuccess
  }
}
