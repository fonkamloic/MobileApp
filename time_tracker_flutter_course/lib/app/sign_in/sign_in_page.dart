import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/SocialSignInButton.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_page_bloc_based.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_bloc.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:flutter/services.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.bloc});

  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
          builder: (context, bloc, _) => SignInPage(bloc: bloc)),
    );
  }

  Widget _buildHeader(bool _isLoading) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await bloc.signInWithFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (context) => EmailSignInPageBlocBased.create(context),
        fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: StreamBuilder<bool>(
          initialData: false,
          stream: bloc.isLoadingStream$,
          builder: (context, snapshot) {
            bool _loading = snapshot.data;
            return _buildContent(context, _loading);
          }),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context, bool _isLoading) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 50, child: _buildHeader(_isLoading)),
          SizedBox(
            height: 48,
          ),
          SocialSignInButton(
            textColor: Colors.black,
            text: 'Sign in with Google',
            imagePath: 'assets/images/google-logo.png',
            color: Colors.white,
            onPressed: _isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 8,
          ),
          SocialSignInButton(
            textColor: Colors.white,
            text: 'Sign in with Facebook',
            imagePath: 'assets/images/facebook-logo.png',
            color: Color(0xff334d93),
            onPressed: _isLoading ? null : () => _signInWithFacebook(context),
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: 'Sign in with email',
            textColor: Colors.white,
            color: Color(0xff016D60),
            onPressed: _isLoading ? null : () => _signInWithEmail(context),
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
            onPressed: _isLoading ? null : () => _signInAnonymously(context),
            textColor: Colors.black,
            text: 'Go anonymous',
            color: Colors.yellow[200],
          ),
        ],
      ),
    );
  }
}
