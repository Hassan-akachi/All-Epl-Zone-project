const String RouteHome = '/'; //HomeScreen(),
const String RouteNation = '/nations'; //const NationsScreen(),
const String RouteTeam = '/teams'; // TeamsScreen(),
const String RoutePosition = '/positions'; // PositionsScreen(),
const String RoutePlayerData = '/player-data'; //PlayerDataScreen(),
const String RouteUser = '/user-screen'; //UserScreen(),
const String RouteGuessingGame = '/guessing-game';
const String RouteSignIn = '/sign-in';
const String RouteSignUp = '/sign-up';
const String RouteEditingProfile = '/editing-profile';
const String RouteSplash = '/splash';






// Team data with proper display names and image mappings
final List<Map<String, String>> teams = [
  {'id': 'arsenal', 'name': 'Arsenal'},
  {'id': 'chelsea', 'name': 'Chelsea'},
  {'id': 'brighton', 'name': 'Brighton & Hove Albion'},
  {'id': 'brentford', 'name': 'Brentford'},
  {'id': 'bournemouth', 'name': 'AFC Bournemouth'},
  {'id': 'crystal-palace', 'name': 'Crystal Palace'},
  {'id': 'everton', 'name': 'Everton'},
  {'id': 'fulham', 'name': 'Fulham'},
  {'id': 'liverpool', 'name': 'Liverpool'},
  {'id': 'manchester-city', 'name': 'Manchester City'},
  {'id': 'manchester-united', 'name': 'Manchester United'},
  {'id': 'newcastle-united', 'name': 'Newcastle United'},
  {'id': 'tottenham-hotspur', 'name': 'Tottenham Hotspur'},
  {'id': 'west-ham-united', 'name': 'West Ham United'},
  {'id': 'aston-villa', 'name': 'Aston Villa'},
  {'id': 'leicester-city', 'name': 'Leicester City'},
  {'id': 'leeds-united', 'name': 'Leeds United'},
  {'id': 'nottingham-forest', 'name': 'Nottingham Forest'},
  {'id': 'southampton', 'name': 'Southampton'},
  {'id': 'wolverhampton-wanderers', 'name': 'Wolverhampton Wanderers'},
];

// Helper method to get image URL for a team
String getImageUrl(String teamId) {
  final imageMappings = {
    'arsenal': 'assets/images/eplLogo/Arsenal FC logo.svg',
    'chelsea': 'assets/images/eplLogo/Chelsea FC logo - Brandlogos.net.svg',
    'brighton': 'assets/images/eplLogo/brighton hove albion.svg', // You'll need to add this file
    'brentford': 'assets/images/eplLogo/Brentford FC logo vector.svg',
    'bournemouth': 'assets/images/eplLogo/Bournemouth logo - Brandlogos.net.svg',
    'crystal-palace': 'assets/images/eplLogo/Crystal Palace FC logo - Brandlogos.net.svg',
    'everton': 'assets/images/eplLogo/Everton FC logo - Brandlogos.net.svg',
    'fulham': 'assets/images/eplLogo/fulham-fc-logo.svg',
    'liverpool': 'assets/images/eplLogo/Liverpool Football Club logo - Brandlogos.net.svg',
    'manchester-city': 'assets/images/eplLogo/Manchester City FC logo.svg',
    'manchester-united': 'assets/images/eplLogo/Manchester United F.C. logo - Brandlogos.net.svg',
    'newcastle-united': 'assets/images/eplLogo/Newcastle United FC logo - Brandlogos.net.svg',
    'tottenham-hotspur': 'assets/images/eplLogo/tottenham-hotspur-fc-logo.png',
    'west-ham-united': 'assets/images/eplLogo/West Ham United FC logo - Brandlogos.net.svg',
    'aston-villa': 'assets/images/eplLogo/aston-villa-logo.svg',
    'leicester-city': 'assets/images/eplLogo/Leicester City FC logo - Brandlogos.net.svg',
    'leeds-united': 'assets/images/eplLogo/leeds-united-fc.svg',
    'nottingham-forest': 'assets/images/eplLogo/Nottingham Forest logo.svg',
    'southampton': 'assets/images/eplLogo/Southampton FC logo.svg',
    'wolverhampton-wanderers': 'assets/images/eplLogo/Wolverhampton Wanderers FC logo.svg',
  };

  return imageMappings[teamId] ?? 'assets/images/eplLogo/Premier League 2007-2016 logo - Brandlogos.net.svg';
}