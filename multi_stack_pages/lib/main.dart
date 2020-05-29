import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    Provider.value(value: StreamBackStackSupport()),
    StreamProvider<homePages>(
      create: (context) =>
          Provider.of<StreamBackStackSupport>(context, listen: false)
              .selectedPage,
    )
  ], child: StartupApplication()));
}

class StartupApplication extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BackStack Support App',
      home: MainBodyApp(),
    );
  }
}



class MainBodyApp extends HookWidget {
  final List<Widget> _fragments = [
    DashboardPage(),
    UserProfilePage(),
    SearchPage()
  ];
  List<int> _backStack = [0];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BackStack Screen'),
      ),
      body: HomeView(),
    );
  }

  void navigateBack(int index) {
    useState(() => _currentIndex = index);
  }

  void customPop(BuildContext context) {
    if (_backStack.length - 1 > 0) {
      navigateBack(_backStack[_backStack.length - 1]);
    } else {
      _backStack.removeAt(_backStack.length - 1);
      Provider.of<StreamBackStackSupport>(context, listen: false)
          .switchBetweenPages(homePages.values[_backStack.length - 1]);
      Navigator.pop(context);
    }
  }
}


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope( 
      
              onWillPop: () async => !await navigatorKey.currentState.maybePop(),
child: CupertinoTabScaffold(),
        tabBar: CupertinoTabBar(items: [
          DashboardPage(),

        ],)
    );
  }
}

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(' screenProfile ...'),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(' screenDashboard ...'),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(' screenSearch ...'),
    );
  }
}

enum homePages { screenDashboard, screenProfile, screenSearch }

class StreamBackStackSupport {
  final StreamController<homePages> _homePages = StreamController<homePages>();

  Stream<homePages> get selectedPage => _homePages.stream;

  void switchBetweenPages(homePages selectedPage) {
    _homePages.add(homePages.values[selectedPage.index]);
  }

  void close() {
    _homePages.close();
  }
}