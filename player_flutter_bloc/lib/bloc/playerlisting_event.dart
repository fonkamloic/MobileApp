part of 'playerlisting_bloc.dart';

abstract class PlayerlistingEvent extends Equatable {
  const PlayerlistingEvent();
}

class CountrySelectedEvent extends PlayerlistingEvent {
  final NationModel nationModel;

  const CountrySelectedEvent({ @required this.nationModel}) : assert(nationModel != null);

  @override
  List<Object> get props => [nationModel];

}
