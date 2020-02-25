import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _email = '';
    String _password = '';
    String _username = '';

    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Card(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(),
                TextFormField(),
                TextFormField(),
                RaisedButton(
                  child: Text('Register'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text('Already have an account? Login'),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => EmailRegisterPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
