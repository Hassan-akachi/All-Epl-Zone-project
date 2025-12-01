// lib/features/player/providers/player_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../core/network/datasource/player_network_datasource.dart';
import '../../core/network/responses/network_response.dart';
import '../../core/network/service/player_service.dart';
import '../../models/player.dart';
import '../auth_provider/auth_provider.dart';


// Player network datasource provider
final playerNetworkProvider = Provider<PlayerNetworkDataSource>((ref) {
  final networkClient = ref.watch(networkClientProvider);
  return PlayerNetworkDataSource(networkClient);
});

// Player service provider
final playerServiceProvider = Provider<PlayerService>((ref) {
  final playerNetwork = ref.watch(playerNetworkProvider);
  return PlayerService(playerNetwork: playerNetwork);
});

// All players provider (cached)
final allPlayersProvider = FutureProvider<List<Player>>((ref) async {
  final playerService = ref.watch(playerServiceProvider);
  final response = await playerService.getAllPlayers();

  return switch (response) {
    NetworkSuccess(data: final players) => players,
    NetworkFailure(message: final msg) => throw Exception(msg),
    NetworkException(message: final msg) => throw Exception(msg),
  };
});


// Search query state provider
final playerSearchQueryProvider = StateProvider<String>((ref) => '');

// Filtered players provider (based on search query)
final filteredPlayersProvider = Provider<List<Player>>((ref) {
  final playersAsync = ref.watch(allPlayersProvider);
  final searchQuery = ref.watch(playerSearchQueryProvider);

  return playersAsync.when(
    data: (players) {
      if (searchQuery.isEmpty) return players;

      final lowerQuery = searchQuery.toLowerCase().trim();
      return players.where((player) {
        return player.player.toLowerCase().contains(lowerQuery) ||
            player.team.toLowerCase().contains(lowerQuery) ||
            (player.nation?.toLowerCase().contains(lowerQuery) ?? false) ||
            player.pos.toLowerCase().contains(lowerQuery);
      }).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

// Top scorers provider
final topScorersProvider = FutureProvider<List<Player>>((ref) async {
  final playerService = ref.watch(playerServiceProvider);
  final response = await playerService.getTopScorers();

  return switch (response) {
    NetworkSuccess(data: final players) => players,
    NetworkFailure(message: final msg) => throw Exception(msg),
    NetworkException(message: final msg) => throw Exception(msg),
  };
});

// Team top scorers provider (requires team parameter)
final teamTopScorersProvider = FutureProvider.family<List<Player>, String>((ref, team) async {
  final playerService = ref.watch(playerServiceProvider);
  final response = await playerService.getTeamTopScorers(team);

  return switch (response) {
    NetworkSuccess(data: final players) => players,
    NetworkFailure(message: final msg) => throw Exception(msg),
    NetworkException(message: final msg) => throw Exception(msg),
  };
});

// Player by ID provider
final playerByIdProvider = FutureProvider.family<Player, String>((ref, id) async {
  final playerService = ref.watch(playerServiceProvider);
  final response = await playerService.getPlayerById(id);

  return switch (response) {
    NetworkSuccess(data: final player) => player,
    NetworkFailure(message: final msg) => throw Exception(msg),
    NetworkException(message: final msg) => throw Exception(msg),
  };
});