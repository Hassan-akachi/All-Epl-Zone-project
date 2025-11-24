// lib/main.dart
import 'package:epl_zone/screens/edit_profile_screen.dart';
import 'package:epl_zone/screens/guessing_game_screen.dart';
import 'package:epl_zone/screens/sign_in_screen.dart';
import 'package:epl_zone/screens/sign_up_screen.dart';
import 'package:epl_zone/screens/splash_screen.dart';
import 'package:epl_zone/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/util/constant.dart';
import 'screens/home_screen.dart';
import 'screens/teams_screen.dart';
import 'screens/nations_screen.dart';
import 'screens/positions_screen.dart';
import 'screens/player_data_screen.dart';

void main() {
  runApp(const PremierZoneApp());
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

