part of 'playerlisting_bloc.dart';

abstract class PlayerListingState extends Equatable {
  const PlayerListingState();
}


class PlayerUninitializedState extends PlayerListingState {
  @override
  List<Object> get props => [];
}

class PlayerFetchingState extends PlayerListingState {
  @override
  List<Object> get props => [];
}

class PlayerFetchedState extends PlayerListingState {
  final List<Player> players;

  PlayerFetchedState({this.players}) : assert (players != null);
  @override
  List<Object> get props => [];
}

class PlayerErrorState extends PlayerListingState {
  @override
  List<Object> get props => [];
}

class PlayerEmptyState extends PlayerListingState {
  @override
  List<Object> get props => [];
}
