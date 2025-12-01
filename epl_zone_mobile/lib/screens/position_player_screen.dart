// lib/features/player/screens/position_players_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/player.dart';
import '../provider/player_provider/player_provider.dart';
import '../util/team_constant.dart';

/// Screen that displays all players for a specific position
/// Shows players grouped by team in expansion panels
class PositionPlayersScreen extends ConsumerStatefulWidget {
  final String positionCode; // Position code (GK, DF, MF, FW)
  final String positionName; // Position display name (e.g., "Goalkeepers")

  const PositionPlayersScreen({
    Key? key,
    required this.positionCode,
    required this.positionName,
  }) : super(key: key);

  @override
  ConsumerState<PositionPlayersScreen> createState() =>
      _PositionPlayersScreenState();
}

class _PositionPlayersScreenState extends ConsumerState<PositionPlayersScreen> {
  // Track which expansion panels are open
  final Set<String> _expandedPanels = {};

  // Position colors for visual distinction
  static const Map<String, Color> positionColors = {
    'GK': Color(0xFFFFD700), // Gold for Goalkeepers
    'DF': Color(0xFF1976D2), // Blue for Defenders
    'MF': Color(0xFF388E3C), // Green for Midfielders
    'FW': Color(0xFFD32F2F), // Red for Forwards
  };

  // Position icons
  static const Map<String, IconData> positionIcons = {
    'GK': Icons.sports_handball,
    'DF': Icons.shield,
    'MF': Icons.swap_horiz,
    'FW': Icons.sports_soccer,
  };

  @override
  Widget build(BuildContext context) {
    // Watch all players from the provider
    final playersAsync = ref.watch(allPlayersProvider);

    // Get position color and icon
    final positionColor = positionColors[widget.positionCode] ?? Colors.blue;
    final positionIcon = positionIcons[widget.positionCode] ?? Icons.sports;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.positionName),
        centerTitle: true,
        backgroundColor: positionColor,
      ),
      body: playersAsync.when(
        // When data is successfully loaded
        data: (allPlayers) {
          // Filter players by position
          // Note: Some players have multiple positions (e.g., "MF,FW")
          // So we check if the position string contains our position code
          final positionPlayers = allPlayers.where((player) {
            return player.pos.split(',').any(
                  (pos) => pos.trim() == widget.positionCode,
            );
          }).toList();

          // If no players found for this position
          if (positionPlayers.isEmpty) {
            return _buildEmptyState();
          }

          // Group players by team
          final groupedPlayers = _groupPlayersByTeam(positionPlayers);

          return _buildPlayersList(
            groupedPlayers: groupedPlayers,
            positionColor: positionColor,
            positionIcon: positionIcon,
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

  /// Groups players by their team
  /// Returns a map where key is team ID and value is list of players
  Map<String, List<Player>> _groupPlayersByTeam(List<Player> players) {
    final grouped = <String, List<Player>>{};

    for (var player in players) {
      // Create team list if it doesn't exist
      if (!grouped.containsKey(player.team)) {
        grouped[player.team] = [];
      }
      // Add player to their team's list
      grouped[player.team]!.add(player);
    }

    // Sort players within each team by name
    grouped.forEach((team, playersList) {
      playersList.sort((a, b) => a.player.compareTo(b.player));
    });

    // Sort teams alphabetically
    final sortedGrouped = Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );

    return sortedGrouped;
  }

  /// Builds the main players list with expansion panels
  Widget _buildPlayersList({
    required Map<String, List<Player>> groupedPlayers,
    required Color positionColor,
    required IconData positionIcon,
  }) {
    // Calculate total players
    final totalPlayers = groupedPlayers.values
        .fold<int>(0, (sum, players) => sum + players.length);

    return Column(
      children: [
        // Position header section
        _buildPositionHeader(
          positionColor: positionColor,
          positionIcon: positionIcon,
          totalPlayers: totalPlayers,
        ),

        // Expansion panels for each team
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Create expansion panel for each team
              ...groupedPlayers.entries.map((entry) {
                final teamId = entry.key;
                final players = entry.value;
                final teamName = TeamConstants.getDisplayName(teamId);
                final teamLogoUrl = TeamConstants.getImageUrl(teamId);

                return _buildTeamExpansionPanel(
                  teamId: teamId,
                  teamName: teamName,
                  teamLogoUrl: teamLogoUrl,
                  players: players,
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the position header with icon and stats
  Widget _buildPositionHeader({
    required Color positionColor,
    required IconData positionIcon,
    required int totalPlayers,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            positionColor,
            positionColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Column(
        children: [
          // Position icon
          Container(
            width: 100,
            height: 100,
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
            child: Icon(
              positionIcon,
              size: 50,
              color: positionColor,
            ),
          ),
          const SizedBox(height: 16),

          // Position name
          Text(
            widget.positionName,
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

  /// Builds an expansion panel for a specific team
  Widget _buildTeamExpansionPanel({
    required String teamId,
    required String teamName,
    required String teamLogoUrl,
    required List<Player> players,
  }) {
    final isExpanded = _expandedPanels.contains(teamId);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          // Initial expansion state (collapsed by default to avoid clutter)
          initiallyExpanded: false,

          // Team logo as leading
          leading: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(4),
            child: Image.asset(teamLogoUrl),
          ),

          // Team name as title
          title: Text(
            teamName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Player count as subtitle
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
                _expandedPanels.add(teamId);
              } else {
                _expandedPanels.remove(teamId);
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

      // Player details
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

                // Matches played
                Icon(Icons.sports, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${player.mp} matches',
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
          // Goals (relevant for all positions)
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

          // Clean sheets for goalkeepers or assists for other positions
          if (widget.positionCode == 'GK') ...[
            // Show minutes played for goalkeepers
            if (player.min != null) ...[
              const SizedBox(height: 4),
              Text(
                '${(player.min! / 90).toStringAsFixed(0)} games',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ] else ...[
            // Show assists for outfield players
            if (player.ast != null && player.ast! > 0) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.assignment_turned_in,
                      size: 16, color: Colors.blue),
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
              _buildStatRow('Team', TeamConstants.getDisplayName(player.team)),
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
                _buildStatRow(
                    'Expected Goals (xG)', '${player.xg!.toStringAsFixed(2)}'),
              if (player.xag != null)
                _buildStatRow('Expected Assists (xAG)',
                    '${player.xag!.toStringAsFixed(2)}'),
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
  Widget _buildEmptyState() {
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
              'No ${widget.positionName.toLowerCase()} available',
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