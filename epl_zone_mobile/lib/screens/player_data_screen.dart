// lib/screens/player_data_screen.dart
import 'package:flutter/material.dart';
import '../models/player.dart';
import '../services/player_api_service.dart';

class PlayerDataScreen extends StatefulWidget {
  const PlayerDataScreen({Key? key}) : super(key: key);

  @override
  State<PlayerDataScreen> createState() => _PlayerDataScreenState();
}

class _PlayerDataScreenState extends State<PlayerDataScreen> {
  final PlayerApiService _apiService = PlayerApiService();
  final TextEditingController _searchController = TextEditingController();

  List<Player> _players = [];
  List<Player> _filteredPlayers = [];
  bool _isLoading = true;
  String? _error;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadPlayers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPlayers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final players = await _apiService.getAllPlayers();
      setState(() {
        _players = players;
        _filteredPlayers = players;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterPlayers(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredPlayers = _players;
      } else {
        _filteredPlayers = _players
            .where((player) =>
            player.player.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Data'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPlayers,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        // Header and Search
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Player Data',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _searchController,
                onChanged: _filterPlayers,
                decoration: InputDecoration(
                  hintText: 'Search players...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Content
        Expanded(
          child: Card(
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading player data...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Failed to load player data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Make sure your API server is running on http://localhost:8080',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _loadPlayers,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_filteredPlayers.isEmpty) {
      return Center(
        child: Text(
          _searchQuery.isEmpty
              ? 'No player data available'
              : 'No players found matching your search',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.primary,
          ),
          headingTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          dataRowHeight: 56,
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Position')),
            DataColumn(label: Text('Age')),
            DataColumn(label: Text('Matches Played')),
            DataColumn(label: Text('Starts')),
            DataColumn(label: Text('Minutes Played')),
            DataColumn(label: Text('Goals')),
            DataColumn(label: Text('Assists')),
            DataColumn(label: Text('Penalties Kicked')),
            DataColumn(label: Text('Yellow Cards')),
            DataColumn(label: Text('Red Cards')),
            DataColumn(label: Text('Expected Goals (xG)')),
            DataColumn(label: Text('Expected Assists (xAG)')),
            DataColumn(label: Text('Team')),
          ],
          rows: _filteredPlayers.map((player) {
            return DataRow(
              cells: [
                DataCell(Text(
                  player.player,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                )),
                DataCell(Text(player.pos)),
                DataCell(Text(player.age.toString())),
                DataCell(Text(player.mp.toString())),
                DataCell(Text(player.starts.toString())),
                DataCell(Text(player.min.toStringAsFixed(0))),
                DataCell(Text(player.gls.toStringAsFixed(0))),
                DataCell(Text(player.ast.toStringAsFixed(0))),
                DataCell(Text(player.pk.toStringAsFixed(0))),
                DataCell(Text(player.crdy.toStringAsFixed(0))),
                DataCell(Text(player.crdr.toStringAsFixed(0))),
                DataCell(Text(player.xg.toStringAsFixed(2))),
                DataCell(Text(player.xag.toStringAsFixed(2))),
                DataCell(Text(player.team)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}