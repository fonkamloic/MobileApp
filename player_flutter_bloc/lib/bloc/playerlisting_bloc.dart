import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:player_flutter_bloc/models/api_models.dart';
import 'package:player_flutter_bloc/models/nation.dart';
import 'package:player_flutter_bloc/services/repository.dart';

part 'playerlisting_event.dart';
part 'playerlisting_state.dart';

class PlayerListingBloc extends Bloc<PlayerlistingEvent, PlayerListingState> {
  final PlayerRepository playerRepository;

  PlayerListingBloc({this.playerRepository}) : assert(playerRepository != null);
  @override
  PlayerListingState get initialState => PlayerUninitializedState();

  @override
  Stream<PlayerListingState> mapEventToState(
    PlayerlistingEvent event,
  ) async* {
    if (event is CountrySelectedEvent) {
      yield PlayerFetchingState();
      try {
        final List<Player> players = await playerRepository
            .fetchPlayersByCountry(event.nationModel.countryId);
        print(players);
        if (players.length == 0) {
          yield PlayerEmptyState();
        }
        yield PlayerFetchedState(players: players);
      } catch (e) {
        yield PlayerErrorState();
      }
    }
  }
}
