// lib/core/network/datasource/player_network.dart



import '../../../models/player.dart';
import '../../api/api_endpoints.dart';
import '../network_interface.dart';
import '../responses/network_response.dart';

class PlayerNetworkDataSource {
  final NetworkInterface _networkClient;

  PlayerNetworkDataSource(this._networkClient);

  // Get all players
  Future<NetworkResponse<List<Player>>> getAllPlayers({
    String? team,
    String? position,
    String? nation,
    String? name,
  }) async {
    final params = <String, String>{};
    if (team != null) params['team'] = team;
    if (position != null) params['position'] = position;
    if (nation != null) params['nation'] = nation;
    if (name != null) params['name'] = name;

    final queryString = ApiEndpoints.buildQueryParams(params);
    final url = ApiEndpoints.getPlayerUrl(ApiEndpoints.players) + queryString;

    final response = await _networkClient.get<List<dynamic>>(
      url,
      fromJson: (json) => json as List<dynamic>,
    );

    return switch (response) {
      NetworkSuccess(data: final list) => NetworkSuccess(
         list.map((json) => Player.fromJson(json as Map<String, dynamic>)).toList(),
        statusCode: response.statusCode,
      ),
      NetworkFailure() => NetworkFailure(
        response.message,
        statusCode: response.statusCode,
      ),
      NetworkException() => NetworkException(
        message: response.message,
        exception: response.exception,
      ),
    };
  }

  // Advanced search
  Future<NetworkResponse<List<Player>>> searchPlayers({
    String? team,
    String? position,
    String? nation,
  }) async {
    final params = <String, String>{};
    if (team != null) params['team'] = team;
    if (position != null) params['position'] = position;
    if (nation != null) params['nation'] = nation;

    final queryString = ApiEndpoints.buildQueryParams(params);
    final url = ApiEndpoints.getPlayerUrl(ApiEndpoints.searchPlayers) + queryString;

    final response = await _networkClient.get<List<dynamic>>(
      url,
      fromJson: (json) => json as List<dynamic>,
    );

    return switch (response) {
      NetworkSuccess(data: final list) => NetworkSuccess(
         list.map((json) => Player.fromJson(json as Map<String, dynamic>)).toList(),
        statusCode: response.statusCode,
      ),
      NetworkFailure() => NetworkFailure(
         response.message,
        statusCode: response.statusCode,
      ),
      NetworkException() => NetworkException(
        message: response.message,
        exception: response.exception,
      ),
    };
  }

  // Get player by ID
  Future<NetworkResponse<Player>> getPlayerById(String id) async {
    final url = ApiEndpoints.getPlayerUrl(ApiEndpoints.playerById(id));

    return await _networkClient.get<Player>(
      url,
      fromJson: (json) => Player.fromJson(json),
    );
  }

  // Get top scorers
  Future<NetworkResponse<List<Player>>> getTopScorers() async {
    final url = ApiEndpoints.getPlayerUrl(ApiEndpoints.topScorers);

    final response = await _networkClient.get<List<dynamic>>(
      url,
      fromJson: (json) => json as List<dynamic>,
    );

    return switch (response) {
      NetworkSuccess(data: final list) => NetworkSuccess(
         list.map((json) => Player.fromJson(json as Map<String, dynamic>)).toList(),
        statusCode: response.statusCode,
      ),
      NetworkFailure() => NetworkFailure(
         response.message,
        statusCode: response.statusCode,
      ),
      NetworkException() => NetworkException(
        message: response.message,
        exception: response.exception,
      ),
    };
  }

  // Get team top scorers
  Future<NetworkResponse<List<Player>>> getTeamTopScorers(String team) async {
    final url = ApiEndpoints.getPlayerUrl(ApiEndpoints.teamTopScorers(team));

    final response = await _networkClient.get<List<dynamic>>(
      url,
      fromJson: (json) => json as List<dynamic>,
    );

    return switch (response) {
      NetworkSuccess(data: final list) => NetworkSuccess(
         list.map((json) => Player.fromJson(json as Map<String, dynamic>)).toList(),
        statusCode: response.statusCode,
      ),
      NetworkFailure() => NetworkFailure(
         response.message,
        statusCode: response.statusCode,
      ),
      NetworkException() => NetworkException(
        message: response.message,
        exception: response.exception,
      ),
    };
  }

  // Create player
  Future<NetworkResponse<Player>> createPlayer(Player player) async {
    final url = ApiEndpoints.getPlayerUrl(ApiEndpoints.players);

    return await _networkClient.post<Player>(
      url,
      body: player.toJson(),
      fromJson: (json) => Player.fromJson(json),
    );
  }

  // Update player
  Future<NetworkResponse<Player>> updatePlayer(String id, Player player) async {
    final url = ApiEndpoints.getPlayerUrl(ApiEndpoints.playerById(id));

    return await _networkClient.put<Player>(
      url,
      body: player.toJson(),
      fromJson: (json) => Player.fromJson(json),
    );
  }

  // Delete player
  Future<NetworkResponse<void>> deletePlayer(String id) async {
    final url = ApiEndpoints.getPlayerUrl(ApiEndpoints.playerById(id));

    return await _networkClient.delete<void>(url);
  }
}