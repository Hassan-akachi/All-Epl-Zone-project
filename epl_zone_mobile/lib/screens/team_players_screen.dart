// lib/features/player/screens/team_players_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/player.dart';
import '../provider/player_provider/player_provider.dart';
import '../util/team_constant.dart';

/// Screen that displays all players from a specific team
/// Shows players grouped by position in expansion panels
class TeamPlayersScreen extends ConsumerStatefulWidget {
  final String teamId; // Team identifier (e.g., "Arsenal", "Manchester-City")

  const TeamPlayersScreen({
    Key? key,
    required this.teamId,
  }) : super(key: key);

  @override
  ConsumerState<TeamPlayersScreen> createState() => _TeamPlayersScreenState();
}

class _TeamPlayersScreenState extends ConsumerState<TeamPlayersScreen> {
  // Track which expansion panels are open
  final Set<String> _expandedPanels = {};

  @override
  void initState() {
    super.initState();
    // Expand all panels by default
    _expandedPanels.addAll(['GK', 'DF', 'MF', 'FW']);
  }

  @override
  Widget build(BuildContext context) {
    // Watch all players from the provider
    final playersAsync = ref.watch(allPlayersProvider);

    // Get team display name and logo
    final teamName = TeamConstants.getDisplayName(widget.teamId);
    final teamLogoUrl = TeamConstants.getImageUrl(widget.teamId);
    final isSvg = TeamConstants.isSvgImage(teamLogoUrl);

    return Scaffold(
      appBar: AppBar(
        title: Text(teamName),
        centerTitle: true,
      ),
      body: playersAsync.when(
        // When data is successfully loaded
        data: (allPlayers) {
          // Filter players for this specific team
          final teamPlayers = allPlayers
              .where((player) => player.team == widget.teamId)
              .toList();

          // If no players found for this team
          if (teamPlayers.isEmpty) {
            return _buildEmptyState(teamName);
          }

          // Group players by position
          final groupedPlayers = _groupPlayersByPosition(teamPlayers);

          return _buildPlayersList(
            groupedPlayers: groupedPlayers,
            teamName: teamName,
            teamLogoUrl: teamLogoUrl,
            isSvg: isSvg,
          );
        },
        // While data is loading
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        // If there's an error loading data
        error: (error, stack) => _buildErrorState(error),
      ),
    );
  }

  /// Groups players by their primary position
  /// Returns a map where key is position code and value is list of players
  Map<String, List<Player>> _groupPlayersByPosition(List<Player> players) {
    final grouped = <String, List<Player>>{
      'GK': [], // Goalkeepers
      'DF': [], // Defenders
      'MF': [], // Midfielders
      'FW': [], // Forwards
    };

    for (var player in players) {
      // Get the primary position (first position if multiple listed)
      final primaryPosition = player.pos.split(',').first.trim();

      // Add player to appropriate group
      if (grouped.containsKey(primaryPosition)) {
        grouped[primaryPosition]!.add(player);
      } else {
        // If position doesn't match standard categories, add to MF as default
        grouped['MF']!.add(player);
      }
    }

    // Sort players within each group by name
    grouped.forEach((position, playersList) {
      playersList.sort((a, b) => a.player.compareTo(b.player));
    });

    return grouped;
  }

  /// Builds the main players list with expansion panels
  Widget _buildPlayersList({
    required Map<String, List<Player>> groupedPlayers,
    required String teamName,
    required String teamLogoUrl,
    required bool isSvg,
  }) {
    // Position names and icons for display
    final positionInfo = {
      'GK': {'name': 'Goalkeepers', 'icon': Icons.sports_handball},
      'DF': {'name': 'Defenders', 'icon': Icons.shield},
      'MF': {'name': 'Midfielders', 'icon': Icons.swap_horiz},
      'FW': {'name': 'Forwards', 'icon': Icons.sports_soccer},
    };

    // Calculate total players
    final totalPlayers = groupedPlayers.values
        .fold<int>(0, (sum, players) => sum + players.length);

    return Column(
      children: [
        // Team header section
        _buildTeamHeader(
          teamName: teamName,
          teamLogoUrl: teamLogoUrl,
          isSvg: isSvg,
          totalPlayers: totalPlayers,
        ),

        // Expansion panels for each position
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Create expansion panel for each position
              ...positionInfo.entries.map((entry) {
                final positionCode = entry.key;
                final info = entry.value;
                final players = groupedPlayers[positionCode]!;

                // Skip if no players in this position
                if (players.isEmpty) return const SizedBox.shrink();

                return _buildPositionExpansionPanel(
                  positionCode: positionCode,
                  positionName: info['name'] as String,
                  positionIcon: info['icon'] as IconData,
                  players: players,
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the team header with logo and stats
  Widget _buildTeamHeader({
    required String teamName,
    required String teamLogoUrl,
    required bool isSvg,
    required int totalPlayers,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.7),
          ],
        ),
      ),
      child: Column(
        children: [
          // Team logo
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(teamLogoUrl), // You may need ImageDisplay widget for SVG
          ),
          const SizedBox(height: 16),

          // Team name
          Text(
            teamName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Player count
          Text(
            '$totalPlayers Players',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds an expansion panel for a specific position
  Widget _buildPositionExpansionPanel({
    required String positionCode,
    required String positionName,
    required IconData positionIcon,
    required List<Player> players,
  }) {
    final isExpanded = _expandedPanels.contains(positionCode);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          // Initial expansion state
          initiallyExpanded: isExpanded,

          // Header section
          leading: Icon(
            positionIcon,
            color: Theme.of(context).colorScheme.primary,
            size: 32,
          ),
          title: Text(
            positionName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${players.length} ${players.length == 1 ? 'player' : 'players'}',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),

          // Track expansion state
          onExpansionChanged: (expanded) {
            setState(() {
              if (expanded) {
                _expandedPanels.add(positionCode);
              } else {
                _expandedPanels.remove(positionCode);
              }
            });
          },

          // Player list content
          children: [
            const Divider(height: 1),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: players.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final player = players[index];
                return _buildPlayerTile(player);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a single player list tile
  Widget _buildPlayerTile(Player player) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      // Player name
      title: Text(
        player.player,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),

      // Player details (age, position, nation)
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Age
                if (player.age != null) ...[
                  Icon(Icons.cake, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${player.age} years',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 16),
                ],

                // Position
                Icon(Icons.sports, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  player.pos,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),

            // Nation
            if (player.nationName != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.flag, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    player.nationName!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),

      // Player statistics (trailing)
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Goals
          if (player.gls != null && player.gls! > 0) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.sports_soccer, size: 16, color: Colors.green),
                const SizedBox(width: 4),
                Text(
                  '${player.gls!.toInt()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],

          // Assists
          if (player.ast != null && player.ast! > 0) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.assignment_turned_in, size: 16, color: Colors.blue),
                const SizedBox(width: 4),
                Text(
                  '${player.ast!.toInt()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),

      // On tap - show detailed player stats dialog
      onTap: () => _showPlayerDetailsDialog(player),
    );
  }

  /// Shows a dialog with detailed player statistics
  void _showPlayerDetailsDialog(Player player) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(player.player),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatRow('Position', player.pos),
              if (player.age != null) _buildStatRow('Age', '${player.age}'),
              if (player.nationName != null)
                _buildStatRow('Nation', player.nationName!),
              const Divider(),
              _buildStatRow('Matches Played', '${player.mp}'),
              _buildStatRow('Starts', '${player.starts}'),
              if (player.min != null)
                _buildStatRow('Minutes', '${player.min!.toInt()}'),
              const Divider(),
              if (player.gls != null)
                _buildStatRow('Goals', '${player.gls!.toInt()}'),
              if (player.ast != null)
                _buildStatRow('Assists', '${player.ast!.toInt()}'),
              if (player.xg != null)
                _buildStatRow('Expected Goals (xG)', '${player.xg!.toStringAsFixed(2)}'),
              if (player.xag != null)
                _buildStatRow('Expected Assists (xAG)', '${player.xag!.toStringAsFixed(2)}'),
              const Divider(),
              if (player.crdy != null)
                _buildStatRow('Yellow Cards', '${player.crdy!.toInt()}'),
              if (player.crdr != null)
                _buildStatRow('Red Cards', '${player.crdr!.toInt()}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  /// Helper to build a stat row in the dialog
  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds empty state when no players found
  Widget _buildEmptyState(String teamName) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_off,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No Players Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'No players available for $teamName',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds error state
  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Error Loading Players',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Retry loading data
                ref.invalidate(allPlayersProvider);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}