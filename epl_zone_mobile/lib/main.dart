// lib/main.dart
import 'package:epl_zone/provider/auth_provider/auth_provider.dart';
import 'package:epl_zone/screens/edit_profile_screen.dart';
import 'package:epl_zone/screens/guessing_game_screen.dart';
import 'package:epl_zone/screens/sign_in_screen.dart';
import 'package:epl_zone/screens/sign_up_screen.dart';
import 'package:epl_zone/screens/splash_screen.dart';
import 'package:epl_zone/screens/user_screen.dart';
import 'package:epl_zone/theme/app_theme.dart';
import 'package:epl_zone/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/teams_screen.dart';
import 'screens/nations_screen.dart';
import 'screens/positions_screen.dart';
import 'screens/player_data_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // Override the SharedPreferences provider with the initialized instance
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const PremierZoneApp(),
    ),
  );
}

class PremierZoneApp extends StatelessWidget {
  const PremierZoneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PremierZone',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteSplash,
      routes: {
        RouteSplash: (context) => const SplashScreen(),
        RouteHome : (context) => const HomeScreen(),
        RouteTeam: (context) => const TeamsScreen(),
        RouteNation: (context) => const NationsScreen(),
        RoutePosition: (context) => const PositionsScreen(),
        RoutePlayerData: (context) => const PlayerDataScreen(),
        RouteUser : (context) => const UserSettingsScreen(),
        RouteGuessingGame : (context) => GuessingGameScreen(),
        RouteEditingProfile : (context) => EditProfileScreen(),
        RouteSignIn : (context)  => SignInScreen(),
        RouteSignUp : (context) => SignUpScreen(),
      },
    );
  }
}

