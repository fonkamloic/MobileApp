import 'package:flutter/material.dart';

class YoutubeMain extends StatefulWidget {
  static String id = "youtubeScreen";
  @override
  _YoutubeMainState createState() => _YoutubeMainState();
}

class _YoutubeMainState extends State<YoutubeMain> {
  int _currentIndex = 0;

  _onTapped(int index){
    setState(() {

      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    List
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Image.asset(
          'assets/images/youtube_logo.png',
          height: 200,
          width: 100,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text("Trending"), icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(
              title: Text("Subscription"), icon: Icon(Icons.subscriptions)),
          BottomNavigationBarItem(title: Text("Inbox"), icon: Icon(Icons.mail)),
          BottomNavigationBarItem(
              title: Text("Library"), icon: Icon(Icons.folder)),
        ],
      ),
    );
  }
}
