import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_flutter_bloc/bloc/playerlisting_bloc.dart';
import 'package:player_flutter_bloc/pages/player_listing.dart';
import 'package:player_flutter_bloc/services/repository.dart';
import 'package:player_flutter_bloc/themes/themes.dart';
import 'package:player_flutter_bloc/widgets/horizontal_bar.dart';
import 'package:player_flutter_bloc/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  final PlayerRepository playerRepository;

  HomePage({this.playerRepository});

  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  PlayerListingBloc _playerListingBloc;

  @override
  void initState() {
    super.initState();
    _playerListingBloc =
        PlayerListingBloc(playerRepository: widget.playerRepository);
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
     create: (_) => _playerListingBloc,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            'Football Players',
            style: appBarTextStyle,
          ),
        ),
        body: Column(
          children: <Widget>[
            HorizontalBar(),
            SizedBox(height: 10.0),
            SearchBar(),
            SizedBox(height: 10.0),
            PlayerListing(playerlistingBloc: _playerListingBloc,)
          ],
        ),
      ),
    );
  }
}