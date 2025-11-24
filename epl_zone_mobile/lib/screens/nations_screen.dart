// lib/screens/nations_screen.dart
import 'package:flutter/material.dart';
import '../widgets/image_display.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/team_card.dart'; // We'll create a similar card for nations

class NationsScreen extends StatefulWidget {
  const NationsScreen({Key? key}) : super(key: key);

  @override
  State<NationsScreen> createState() => _NationsScreenState();
}

class _NationsScreenState extends State<NationsScreen> {
  String _searchQuery = '';

  // Top 10 EPL nationalities including Nigeria
  final List<Map<String, dynamic>> nations = [
    {
      'code': 'gb-eng',
      'name': 'England',
      'flag': 'assets/images/country-flags-main/svg/gb-eng.svg',
      'playerCount': 224,
      'primaryColor': Color(0xFFCF142B),
      'secondaryColor': Color(0xFFFFFFFF),
    },
    {
      'code': 'fr',
      'name': 'France',
      'flag': 'assets/images/country-flags-main/svg/fr.svg',
      'playerCount': 32,
      'primaryColor': Color(0xFF0055A4),
      'secondaryColor': Color(0xFFEF4135),
    },
    {
      'code': 'br',
      'name': 'Brazil',
      'flag': 'assets/images/country-flags-main/svg/br.svg',
      'playerCount': 30,
      'primaryColor': Color(0xFF009C3B),
      'secondaryColor': Color(0xFFFFDF00),
    },
    {
      'code': 'es',
      'name': 'Spain',
      'flag': 'assets/images/country-flags-main/svg/es.svg',
      'playerCount': 25,
      'primaryColor': Color(0xFFC60B1E),
      'secondaryColor': Color(0xFFF1BF00),
    },
    {
      'code': 'ie',
      'name': 'Ireland',
      'flag': 'assets/images/country-flags-main/svg/ie.svg',
      'playerCount': 18,
      'primaryColor': Color(0xFF009A44),
      'secondaryColor': Color(0xFFFFFFFF),
    },
    {
      'code': 'pt',
      'name': 'Portugal',
      'flag': 'assets/images/country-flags-main/svg/pt.svg',
      'playerCount': 17,
      'primaryColor': Color(0xFF006600),
      'secondaryColor': Color(0xFFFF0000),
    },
    {
      'code': 'nl',
      'name': 'Netherlands',
      'flag': 'assets/images/country-flags-main/svg/nl.svg',
      'playerCount': 16,
      'primaryColor': Color(0xFF21468B),
      'secondaryColor': Color(0xFFAE1C28),
    },
    {
      'code': 'ng',
      'name': 'Nigeria',
      'flag': 'assets/images/country-flags-main/svg/ng.svg',
      'playerCount': 15,
      'primaryColor': Color(0xFF008751),
      'secondaryColor': Color(0xFFFFFFFF),
    },
    {
      'code': 'be',
      'name': 'Belgium',
      'flag': 'assets/images/country-flags-main/svg/be.svg',
      'playerCount': 14,
      'primaryColor': Color(0xFF000000),
      'secondaryColor': Color(0xFFFDDA25),
    },
    {
      'code': 'de',
      'name': 'Germany',
      'flag': 'assets/images/country-flags-main/svg/de.svg',
      'playerCount': 13,
      'primaryColor': Color(0xFF000000),
      'secondaryColor': Color(0xFFFF0000),
    },
  ];

  List<Map<String, dynamic>> get filteredNations {
    if (_searchQuery.isEmpty) return nations;
    return nations.where((nation) {
      return nation['name'].toString().toLowerCase().contains(
        _searchQuery.toLowerCase(),
      ) ||
          nation['code'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nations')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nations', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 24),
            SearchBarWidget(
              placeholder: 'Search for countries',
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
              itemCount: filteredNations.length,
              itemBuilder: (context, index) {
                final nation = filteredNations[index];
                return _NationCard(nation: nation);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NationCard extends StatelessWidget {
  final Map<String, dynamic> nation;

  const _NationCard({required this.nation});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigate to nation details
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${nation['name']} selected'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                nation['primaryColor'] as Color,
                nation['secondaryColor'] as Color,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Flag container
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ImageDisplay(
                    imageUrl: nation['flag'] as String,
                    isSvg: true, // All flags are SVG
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                nation['name'] as String,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '${nation['playerCount']} players',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 2,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}