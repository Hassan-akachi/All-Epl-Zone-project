// lib/services/player_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/player.dart';
import '../../../models/player_filters.dart';

class PlayerApiService {
  static  String playersDataBaseUrl = '${playersDataBaseUrl}api/v1';

  // For Android Emulator use: http://10.0.2.2:8080/api/v1
  // For iOS Simulator use: http://localhost:8080/api/v1
  // For real device use your computer's IP: http://192.168.x.x:8080/api/v1

  Future<List<Player>> getAllPlayers([PlayerFilters? filters]) async {
    try {
      final uri = Uri.parse('$playersDataBaseUrl/players');
      final queryParams = filters?.toQueryParams() ?? {};
      final finalUri = uri.replace(queryParameters: queryParams);

      final response = await http.get(finalUri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Player.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load players: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching players: $e');
    }
  }

  Future<Player> getPlayerById(String id) async {
    try {
      final response = await http.get(Uri.parse('$playersDataBaseUrl/players/$id'));

      if (response.statusCode == 200) {
        return Player.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load player: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching player: $e');
    }
  }

  Future<List<Player>> searchPlayers(PlayerFilters filters) async {
    try {
      final uri = Uri.parse('$playersDataBaseUrl/players/search');
      final finalUri = uri.replace(queryParameters: filters.toQueryParams());

      final response = await http.get(finalUri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Player.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search players: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching players: $e');
    }
  }

  Future<List<Player>> getTopScorers() async {
    try {
      final response = await http.get(Uri.parse('$playersDataBaseUrl/players/top-scorers'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Player.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load top scorers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching top scorers: $e');
    }
  }

  Future<List<Player>> getTeamTopScorers(String team) async {
    try {
      final response = await http.get(
        Uri.parse('$playersDataBaseUrl/players/teams/$team/top-scorers'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Player.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load team top scorers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching team top scorers: $e');
    }
  }

  Future<Player> createPlayer(Player player) async {
    try {
      final response = await http.post(
        Uri.parse('$playersDataBaseUrl/players'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(player.toJson()),
      );

      if (response.statusCode == 201) {
        return Player.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create player: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating player: $e');
    }
  }

  Future<Player> updatePlayer(String id, Player player) async {
    try {
      final response = await http.put(
        Uri.parse('$playersDataBaseUrl/players/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(player.toJson()),
      );

      if (response.statusCode == 200) {
        return Player.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update player: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating player: $e');
    }
  }

  Future<void> deletePlayer(String id) async {
    try {
      final response = await http.delete(Uri.parse('$playersDataBaseUrl/players/$id'));

      if (response.statusCode != 204) {
        throw Exception('Failed to delete player: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting player: $e');
    }
  }
}