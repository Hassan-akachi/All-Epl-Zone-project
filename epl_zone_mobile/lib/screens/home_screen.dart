// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../util/constant.dart';
import '../widgets/feature_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PremierZone'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, RouteUser);
            },
          ),

          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, RoutePlayerData);
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'Welcome to PremierZone',
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Your comprehensive Premier League statistics platform',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.grey[600],
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 1;
                if (constraints.maxWidth > 900) {
                  crossAxisCount = 4;
                } else if (constraints.maxWidth > 600) {
                  crossAxisCount = 2;
                }

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 1,
                  children: [
                    FeatureCard(
                      icon: Icons.group,
                      title: 'Teams',
                      description: 'Browse all Premier League teams',
                      color: Colors.blue,
                      onTap: () => Navigator.pushNamed(context, '/teams'),
                      backgroundImageUrl: 'assets/images/category/team.png' ,
                    ),
                    FeatureCard(
                      icon: Icons.flag,
                      title: 'Nations',
                      description: 'Explore players by nationality',
                      color: Colors.green,
                      onTap: () => Navigator.pushNamed(context, '/nations'),
                      backgroundImageUrl: 'assets/images/category/nation.jpg',
                    ),
                    FeatureCard(
                      icon: Icons.person,
                      title: 'Positions',
                      description: 'View players by position',
                      color: Colors.purple,
                      onTap: () => Navigator.pushNamed(context, '/positions'),
                      backgroundImageUrl: 'assets/images/category/position.jpg',
                    ),
                    FeatureCard(
                      icon: Icons.storage,
                      title: 'Player Data',
                      description: 'Comprehensive player statistics',
                      color: Colors.orange,
                      onTap: () => Navigator.pushNamed(context, '/player-data'),
                      backgroundImageUrl: 'assets/images/category/data.png',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF295F75)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'PremierZone',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Premier League Statistics',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          _buildDrawerItem(
            context,
            icon: Icons.person_search,
            title: 'Guess the Player',
            route: RouteGuessingGame,
          ),

          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            route: '/',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.group,
            title: 'Teams',
            route: '/teams',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.flag,
            title: 'Nations',
            route: '/nations',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person,
            title: 'Positions',
            route: '/positions',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.storage,
            title: 'Player Data',
            route: '/player-data',
          ),

          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Settings',
            route:  RouteUser,
          ),

          SizedBox(height: 30,),
          const Divider(),

          // --- Custom Sign In/Footer Item (Syntax Fixed) ---
          InkWell(
            child: Container(
              height: 50,
              width: 200,
              // Increased height for better visibility
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration:  BoxDecoration(
                border: Border.all(
                 color: AppTheme.secondary,
                    width: 1.0
                ),
              ),
              child: const Text(
                "Sign In / Profile",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF295F75),
                ),
              ),
            ),
            onTap: (){
              Navigator.of(context).pushNamed(RouteSignIn);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    final isCurrentRoute = ModalRoute.of(context)?.settings.name == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isCurrentRoute ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isCurrentRoute ? FontWeight.bold : FontWeight.normal,
          color: isCurrentRoute ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      selected: isCurrentRoute,
      selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      onTap: () {
        Navigator.pop(context);
        if (!isCurrentRoute) {
          //Navigator.pushReplacementNamed(context, route);
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
