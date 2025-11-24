// lib/screens/teams_screen.dart
import 'package:flutter/material.dart';
import '../core/util/constant.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/team_card.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({Key? key}) : super(key: key);

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  String _searchQuery = '';



  // Helper method to check if image is SVG
  bool _isSvgImage(String imageUrl) {
    return imageUrl.toLowerCase().endsWith('.svg');
  }

  List<Map<String, String>> get filteredTeams {
    if (_searchQuery.isEmpty) return teams;
    return teams
        .where((team) => team['name']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Teams',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 24),
            SearchBarWidget(
              placeholder: 'Search for teams',
              value: _searchQuery,
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 32),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 900
                    ? 4
                    : MediaQuery.of(context).size.width > 600
                    ? 2
                    : 1,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 0.9,
              ),
              itemCount: filteredTeams.length,
              itemBuilder: (context, index) {
                final team = filteredTeams[index];
                final teamId = team['id']!;
                final teamName = team['name']!;
                final imageUrl = getImageUrl(teamId);
                final isSvg = _isSvgImage(imageUrl);

                return TeamCard(
                  teamName: teamName,
                  imageUrl: imageUrl,
                  isSvg: isSvg,
                  onTap: () {
                    // Navigate to team details or show snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$teamName selected'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}