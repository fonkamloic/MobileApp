import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String uid;

  User({@required this.uid});
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;

  Future<User> currentUser();

  Future<User> signInAnonymously();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> createUserWithEmailAndPassword(String email, String password);

  Future<User> signInWithFacebook();

  Future<User> signInWithGoogle();

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  // FirebaseUser to User mapper
  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  // Sign IN with google
  @override
  Future<User> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by User',
      );
    }
  }

  // Sign In with Facebook
  @override
  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();

    try {
      final result = await facebookLogin.logInWithReadPermissions(
        ['public_profile'],
      );
      if (result.accessToken != null) {
        final authResult = await _firebaseAuth
            .signInWithCredential(FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        ));
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by User',
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Sign in with email and password
  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(authResult.user);
    } catch (e) {
      print(e.toString());
    }
  }

//Create user with email and password
  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(authResult.user);
    } catch (e) {
      print(e.toString());
    }
  }

  // Get current user
  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  // Sign in anonymously
  @override
  Future<User> signInAnonymously() async {
    try {
      final authResult = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(authResult.user);
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign Out
  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    final facebookLogin = FacebookLogin();
    await googleSignIn.signOut();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }
}
