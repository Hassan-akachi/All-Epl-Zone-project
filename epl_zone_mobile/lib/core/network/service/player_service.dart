// lib/features/player/service/player_service.dart



import '../../../models/player.dart';
import '../datasource/player_network_datasource.dart';
import '../responses/network_response.dart';

class PlayerService {
  final PlayerNetworkDataSource _playerNetwork;
  List<Player>? _cachedPlayers;

  PlayerService({required PlayerNetworkDataSource playerNetwork})
      : _playerNetwork = playerNetwork;

  // Get all players with caching
  Future<NetworkResponse<List<Player>>> getAllPlayers({
    bool forceRefresh = false,
  }) async {
    if (_cachedPlayers != null && !forceRefresh) {
      return NetworkSuccess( _cachedPlayers!, statusCode: 200);
    }

    final response = await _playerNetwork.getAllPlayers();

    if (response is NetworkSuccess<List<Player>>) {
      _cachedPlayers = response.data;
    }

    return response;
  }

  // Search players locally from cache
  List<Player> searchPlayersLocally(String query) {
    if (_cachedPlayers == null) return [];

    final lowerQuery = query.toLowerCase().trim();
    if (lowerQuery.isEmpty) return _cachedPlayers!;

    return _cachedPlayers!.where((player) {
      return player.player.toLowerCase().contains(lowerQuery) ||
          player.team.toLowerCase().contains(lowerQuery) ||
          (player.nation?.toLowerCase().contains(lowerQuery) ?? false) ||
          player.pos.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Filter players
  List<Player> filterPlayers({
    String? team,
    String? position,
    String? nation,
  }) {
    if (_cachedPlayers == null) return [];

    return _cachedPlayers!.where((player) {
      bool matches = true;

      if (team != null && team.isNotEmpty) {
        matches = matches && player.team.toLowerCase() == team.toLowerCase();
      }

      if (position != null && position.isNotEmpty) {
        matches = matches && player.pos.toLowerCase().contains(position.toLowerCase());
      }

      if (nation != null && nation.isNotEmpty) {
        matches = matches && (player.nation?.toLowerCase().contains(nation.toLowerCase()) ?? false);
      }

      return matches;
    }).toList();
  }

  // Get player by ID
  Future<NetworkResponse<Player>> getPlayerById(String id) async {
    // Try to find in cache first
    if (_cachedPlayers != null) {
      try {
        final player = _cachedPlayers!.firstWhere((p) => p.id == id);
        return NetworkSuccess(player, statusCode: 200);
      } catch (_) {
        // Not found in cache, fetch from API
      }
    }

    return await _playerNetwork.getPlayerById(id);
  }

  // Get top scorers
  Future<NetworkResponse<List<Player>>> getTopScorers() async {
    return await _playerNetwork.getTopScorers();
  }

  // Get team top scorers
  Future<NetworkResponse<List<Player>>> getTeamTopScorers(String team) async {
    return await _playerNetwork.getTeamTopScorers(team);
  }

  // Get cached players
  List<Player>? get cachedPlayers => _cachedPlayers;

  // Clear cache
  void clearCache() {
    _cachedPlayers = null;
  }
}