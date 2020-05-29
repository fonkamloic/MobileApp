import 'package:player_flutter_bloc/models/api_models.dart';
import 'package:player_flutter_bloc/services/player_api_provider.dart';

class PlayerRepository {
  PlayerApiProvider _playerApiProvider = PlayerApiProvider();

  Future<List<Player>> fetchPlayersByCountry(String countryId) async => await
      _playerApiProvider.fetchPlayersByCountry(countryId);
}
