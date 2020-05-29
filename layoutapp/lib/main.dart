import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  TabBar makeTabBar() {
    return TabBar(
      tabs: <Tab>[
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.settings_power),
        ),
      ],
      controller: tabController,
    );
  }

  TabBarView makeTabBarView(tabs) {
    return TabBarView(
      children: tabs,
      controller: tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        bottom: makeTabBar(),
      ),
      body: widget(child: TheGridView().build()),
    ));
  }
}

class TheGridView {
  Card makeGridCell(String name, IconData icon) {
    return Card(
      elevation: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Center(
            child: Icon(icon),
          ),
          Center(child: Text(name)),
        ],
      ),
    );
  }

  GridView build() {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(1.0),
      primary: true,
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        makeGridCell('Home', Icons.home),
        makeGridCell('Email', Icons.email),
        makeGridCell('Chat', Icons.chat_bubble),
        makeGridCell('News', Icons.new_releases),
        makeGridCell('Network', Icons.network_wifi),
        makeGridCell('Options', Icons.settings),
      ],
    );
  }
}
