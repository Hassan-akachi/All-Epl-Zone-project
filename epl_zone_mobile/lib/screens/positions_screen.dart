// lib/screens/positions_screen.dart
import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/image_display.dart';

class PositionsScreen extends StatefulWidget {
  const PositionsScreen({Key? key}) : super(key: key);

  @override
  State<PositionsScreen> createState() => _PositionsScreenState();
}

class _PositionsScreenState extends State<PositionsScreen> {
  String _searchQuery = '';

  final List<Map<String, dynamic>> positions = [
    {
      'code': 'GK',
      'name': 'Goalkeepers',
      'image': 'assets/images/position/goalkeeper.png',
      'gradient': [Color(0xFFFFD700), Color(0xFFFFA000)], // Gold gradient
    },
    {
      'code': 'DF',
      'name': 'Defenders',
      'image': 'assets/images/position/defender.jpg',
      'gradient': [Color(0xFF1976D2), Color(0xFF0D47A1)], // Blue gradient
    },
    {
      'code': 'MF',
      'name': 'Midfielders',
      'image': 'assets/images/position/midfielders.png',
      'gradient': [Color(0xFF388E3C), Color(0xFF1B5E20)], // Green gradient
    },
    {
      'code': 'FW',
      'name': 'Forwards',
      'image': 'assets/images/position/forward.png',
      'gradient': [Color(0xFFD32F2F), Color(0xFFB71C1C)], // Red gradient
    },
  ];

  List<Map<String, dynamic>> get filteredPositions {
    if (_searchQuery.isEmpty) return positions;
    return positions.where((position) {
      return position['name']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase()) ||
          position['code']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Positions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Positions',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 24),

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
              itemCount: filteredPositions.length,
              itemBuilder: (context, index) {
                final position = filteredPositions[index];
                return _PositionCard(position: position);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Alternative _PositionCard with background images
class _PositionCard extends StatelessWidget {
  final Map<String, dynamic> position;

  const _PositionCard({required this.position});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${position['name']} selected'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(position['image'] as String),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.darken,
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    position['code'] as String,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  position['name'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}