import 'package:cloud_funct/Message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingDemo extends StatefulWidget {
  FirebaseMessagingDemo() : super();

  final String title = "Firebase Messaging Demo";

  @override
  _FirebaseMessagingDemoState createState() => _FirebaseMessagingDemoState();
}

class _FirebaseMessagingDemoState extends State<FirebaseMessagingDemo> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<Message> _messages;

  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("Device Token: $deviceToken");
    });
  }

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      _setMessage(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch: $message');
      _setMessage(message);
    }, onResume: (Map<String, dynamic> message) async {
      print('onResume: $message');
      _setMessage(message);
    });
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    final String mMessage = data['body'];
    setState(() {
      Message m = Message(title, body, mMessage);
      _messages.add(m);
    });
  }

  @override
  void initState() {
    _messages = List<Message>();
    _getToken();
    _configureFirebaseListeners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
            child: ListView.builder(
          itemBuilder: (context, index){
            return ListTile(title: Text(_messages[index].title), subtitle: Text(_messages[index].body),);
          },
          itemCount: _messages == null ? 0 : _messages.length,
        )));
  }
}
