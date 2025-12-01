// lib/core/network/datasource/player_datasource.dart
import '../../api/api_endpoints.dart';
import '../network_interface.dart';
import '../network_client.dart';
import '../../../models/player.dart';
import '../../../models/player_filters.dart';
import '../responses/network_response.dart';

class PlayerDataSource {
  final NetworkInterface _network;

  PlayerDataSource(this._network);

  Future<NetworkResponse<List<Player>>> getAllPlayers([PlayerFilters? filters]) async {
    String url = ApiEndpoints.playersUrl;

    if (filters != null) {
      final params = filters.toQueryParams();
      if (params.isNotEmpty) {
        url += '?${Uri(queryParameters: params).query}';
      }
    }

    return await _network.get<List<Player>>(
      url,
      fromJson: (json) {
        final List<dynamic> data = json['data'] ?? json;
        return data.map((item) => Player.fromJson(item)).toList();
      },
    );
  }

  Future<NetworkResponse<Player>> getPlayerById(String id) async {
    return await _network.get<Player>(
      ApiEndpoints.playerById(id),
      fromJson: (json) => Player.fromJson(json),
    );
  }

  Future<NetworkResponse<List<Player>>> getTopScorers() async {
    return await _network.get<List<Player>>(
      "${ApiEndpoints.playersUrl}/top-scorers",
      fromJson: (json) {
        final List<dynamic> data = json['data'] ?? json;
        return data.map((item) => Player.fromJson(item)).toList();
      },
    );
  }

  Future<NetworkResponse<Player>> createPlayer(Player player) async {
    return await _network.post<Player>(
      ApiEndpoints.playersUrl,
      body: player.toJson(),
      fromJson: (json) => Player.fromJson(json),
    );
  }

  Future<NetworkResponse<Player>> updatePlayer(String id, Player player) async {
    return await _network.put<Player>(
      ApiEndpoints.playerById(id),
      body: player.toJson(),
      fromJson: (json) => Player.fromJson(json),
    );
  }

  Future<NetworkResponse<void>> deletePlayer(String id) async {
    return await _network.delete<void>(
      ApiEndpoints.playerById(id),
    );
  }
}