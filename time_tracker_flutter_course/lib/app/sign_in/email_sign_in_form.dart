
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';


enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  bool _submitted = false;
  bool _isloading = false;

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool _formValid = false;

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _submit(BuildContext context) async {
    setState(() {
      _submitted = true;
      _isloading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.register) {
        await auth.createUserWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      } else {
        await auth.signInWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      }
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in Failed',
        exception: e,
      ).show(context);
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    String primaryText =
    _formType == EmailSignInFormType.signIn ? 'Sign In' : 'Register';
    String secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an Account? Register'
        : 'Already have an account? Login';
    return   Padding(
        padding: EdgeInsets.all(18.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      validator: (val) =>
                      !val.contains('@') || !val.contains('.')
                          ? 'Invalid email'
                          : null,
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: 'yourEmail@domain.com',
                          labelText: 'Email'),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: _emailEditingComplete,
                      onChanged: (val) {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            _formValid = true;
                          } else {
                            _formValid = false;
                          }
                        });
                      },
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      validator: (val) =>
                      val.length < 5 ? 'Password too short' : null,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () => _submit(context),
                      onChanged: (val) {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            _formValid = true;
                          } else {
                            _formValid = false;
                          }
                        });
                      },
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    FormSubmitButton(
                      text: primaryText,
                      onPressed:
                      _formValid ? () => _submit(context) : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      child: Text(secondaryText),
                      onPressed: () {
                        setState(() {
                          _formType =
                          _formType == EmailSignInFormType.signIn
                              ? EmailSignInFormType.register
                              : EmailSignInFormType.signIn;
                          _passwordController.clear();
                          _emailController.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
