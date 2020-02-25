import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign_in/SocialSignInButton.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SignInPage extends StatelessWidget {
  final AuthBase auth;

  SignInPage({ @required this.auth});

  Future<void> _signInAnonymously() async {
    try{
      await auth.signInAnonymously();
    }catch(e){
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
          ),
          SizedBox(
            height: 48,
          ),
          SocialSignInButton(
            textColor: Colors.black,
            text: 'Sign in with Google',
            imagePath: 'assets/images/google-logo.png',
            color: Colors.white,
            onPressed: (){},
          ),
          SizedBox(
            height: 8,
          ),
          SocialSignInButton(
            textColor: Colors.white,
            text: 'Sign in with Facebook',
            imagePath: 'assets/images/facebook-logo.png',
            color: Color(0xff334d93),
            onPressed: (){},
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: 'Sign in with email',
            textColor: Colors.white,
            color: Color(0xff016D60),
            onPressed: () {},
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            onPressed: _signInAnonymously,
            textColor: Colors.black,
            text: 'Go anonymous',
            color: Colors.yellow[200],
          ),
        ],
      ),
    );
  }
}
