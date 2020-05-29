import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_flutter_bloc/bloc/playerlisting_bloc.dart';
import 'package:player_flutter_bloc/models/api_models.dart';
import 'package:player_flutter_bloc/services/repository.dart';
import 'package:player_flutter_bloc/themes/themes.dart';
import 'package:player_flutter_bloc/widgets/message.dart';

class PlayerListing extends StatelessWidget {
  final PlayerListingBloc playerlistingBloc;
  PlayerListing({@required this.playerlistingBloc})
      : assert(playerlistingBloc != null);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerListingBloc, PlayerListingState>(
      bloc: BlocProvider.of<PlayerListingBloc>(context),
      // bloc: playerlistingBloc,
      builder: (context, state) {
        if (state is PlayerUninitializedState) {
          return Message(
              message: "Please select a country flag to fetch players from");
        } else if (state is PlayerEmptyState) {
          return Message(message: "No Players found");
        } else if (state is PlayerErrorState) {
          return Message(message: "Something went wrong");
        } else if (state is PlayerFetchingState) {
          return Expanded(child: Center(child: CircularProgressIndicator()));
        } else {
          final stateAsPlayerFetchedState = state as PlayerFetchedState;
          final players = stateAsPlayerFetchedState.players;
          print("State: $players");
          return buildPlayersList(players);
        }
      },
    );
  }

  Widget buildPlayersList(List<Player> players) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (BuildContext context, index) {
          Player player = players[index];
          return ListTile(
            leading: Image.network(
              player.headshot.imgUrl,
              width: 70.0,
              height: 70.0,
            ),
            title: Text(player.name, style: titleStyle),
            subtitle: Text(player.club.name, style: subTitleStyle),
          );
        },
        separatorBuilder: (BuildContext context, index) {
          return Divider(
            height: 8.0,
            color: Colors.transparent,
          );
        },
        itemCount: players.length,
      ),
    );
  }
}
