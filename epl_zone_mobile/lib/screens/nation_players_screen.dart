// lib/features/player/screens/nation_players_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/player.dart';
import '../provider/player_provider/player_provider.dart';
import '../util/team_constant.dart';

/// Screen that displays all players from a specific nation
/// Shows players grouped by team in expansion panels
class NationPlayersScreen extends ConsumerStatefulWidget {
  final String nationCode; // Nation code (e.g., "eng", "fr", "ng")
  final String nationName; // Nation display name (e.g., "England", "France")
  final String? flagAsset; // Optional flag asset path

  const NationPlayersScreen({
    Key? key,
    required this.nationCode,
    required this.nationName,
    this.flagAsset,
  }) : super(key: key);

  @override
  ConsumerState<NationPlayersScreen> createState() =>
      _NationPlayersScreenState();
}

class _NationPlayersScreenState extends ConsumerState<NationPlayersScreen> {
  // Track which expansion panels are open
  final Set<String> _expandedPanels = {};

  @override
  Widget build(BuildContext context) {
    // Watch all players from the provider
    final playersAsync = ref.watch(allPlayersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nationName),
        centerTitle: true,
      ),
      body: playersAsync.when(
        // When data is successfully loaded
        data: (allPlayers) {
          // Filter players by nation
          // The nation field is stored as "code NAME" (e.g., "eng ENG", "fr FRA")
          // So we need to check if the nation string starts with our nation code
          final nationPlayers = allPlayers.where((player) {
            if (player.nation == null) return false;

            // Get the nation code from the player's nation string
            final playerNationCode =
            player.nation!.split(' ').first.toLowerCase().trim();

            // Compare with our nation code (case-insensitive)
            return playerNationCode == widget.nationCode.toLowerCase().trim();
          }).toList();

          // If no players found for this nation
          if (nationPlayers.isEmpty) {
            return _buildEmptyState();
          }

          // Group players by team
          final groupedPlayers = _groupPlayersByTeam(nationPlayers);

          return _buildPlayersList(
            groupedPlayers: groupedPlayers,
            totalPlayers: nationPlayers.length,
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
  /// Also sorts teams by number of players (descending)
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

    // Sort teams by player count (descending), then alphabetically
    final sortedGrouped = Map.fromEntries(
      grouped.entries.toList()
        ..sort((a, b) {
          // First sort by player count (descending)
          final countComparison = b.value.length.compareTo(a.value.length);
          if (countComparison != 0) return countComparison;
          // If same count, sort alphabetically by team name
          return a.key.compareTo(b.key);
        }),
    );

    return sortedGrouped;
  }

  /// Builds the main players list with expansion panels
  Widget _buildPlayersList({
    required Map<String, List<Player>> groupedPlayers,
    required int totalPlayers,
  }) {
    return Column(
      children: [
        // Nation header section
        _buildNationHeader(
          totalPlayers: totalPlayers,
          totalTeams: groupedPlayers.length,
        ),

        // Expansion panels for each team
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Statistics card
              _buildStatisticsCard(groupedPlayers),

              const SizedBox(height: 16),

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

  /// Builds the nation header with flag and stats
  Widget _buildNationHeader({
    required int totalPlayers,
    required int totalTeams,
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
          // Flag container
          if (widget.flagAsset != null) ...[
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
              child: Image.asset(widget.flagAsset!),
            ),
            const SizedBox(height: 16),
          ],

          // Nation name
          Text(
            widget.nationName,
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

          // Teams count
          Text(
            'Across $totalTeams ${totalTeams == 1 ? 'Team' : 'Teams'}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a statistics card showing aggregated stats
  Widget _buildStatisticsCard(Map<String, List<Player>> groupedPlayers) {
    // Calculate total goals and assists
    int totalGoals = 0;
    int totalAssists = 0;
    int totalMatches = 0;

    for (var players in groupedPlayers.values) {
      for (var player in players) {
        totalGoals += (player.gls ?? 0).toInt();
        totalAssists += (player.ast ?? 0).toInt();
        totalMatches += player.mp;
      }
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Season Statistics',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatBox(
                  icon: Icons.sports_soccer,
                  label: 'Goals',
                  value: '$totalGoals',
                  color: Colors.green,
                ),
                _buildStatBox(
                  icon: Icons.assignment_turned_in,
                  label: 'Assists',
                  value: '$totalAssists',
                  color: Colors.blue,
                ),
                _buildStatBox(
                  icon: Icons.sports,
                  label: 'Matches',
                  value: '$totalMatches',
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build a stat box
  Widget _buildStatBox({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 32, color: color),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
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
          // Initial expansion state
          initiallyExpanded: players.length <= 3, // Auto-expand if few players

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

                // Position
                Icon(Icons.sports, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  player.pos,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),

            // Matches played
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.event, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${player.mp} matches',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
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
              _buildStatRow('Nation', widget.nationName),
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
              'No players from ${widget.nationName} found',
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