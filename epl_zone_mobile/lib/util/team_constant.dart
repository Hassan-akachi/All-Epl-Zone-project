// lib/core/util/team_constants.dart

class TeamConstants {
  // Team data with proper display names and image mappings
  static final List<Map<String, String>> teams = [
    {'id': 'Arsenal', 'name': 'Arsenal'},
    {'id': 'Chelsea', 'name': 'Chelsea'},
    {'id': 'Brighton', 'name': 'Brighton & Hove Albion'},
    {'id': 'Brentford', 'name': 'Brentford'},
    {'id': 'Bournemouth', 'name': 'AFC Bournemouth'},
    {'id': 'Crystal-Palace', 'name': 'Crystal Palace'},
    {'id': 'Everton', 'name': 'Everton'},
    {'id': 'Fulham', 'name': 'Fulham'},
    {'id': 'Liverpool', 'name': 'Liverpool'},
    {'id': 'Manchester-City', 'name': 'Manchester City'},
    {'id': 'Manchester-United', 'name': 'Manchester United'},
    {'id': 'Newcastle-United', 'name': 'Newcastle United'},
    {'id': 'Tottenham-Hotspur', 'name': 'Tottenham Hotspur'},
    {'id': 'West-Ham-United', 'name': 'West Ham United'},
    {'id': 'Aston-Villa', 'name': 'Aston Villa'},
    {'id': 'Leicester-City', 'name': 'Leicester City'},
    {'id': 'Leeds-United', 'name': 'Leeds United'},
    {'id': 'Nottingham-Forest', 'name': 'Nottingham Forest'},
    {'id': 'Southampton', 'name': 'Southampton'},
    {'id': 'Wolverhampton-Wanderers', 'name': 'Wolverhampton Wanderers'},
  ];

  // Helper method to get image URL for a team
  static String getImageUrl(String teamId) {
    final imageMappings = {
      'Arsenal': 'assets/images/eplLogo/Arsenal FC logo.svg',
      'Chelsea': 'assets/images/eplLogo/Chelsea FC logo - Brandlogos.net.svg',
      'Brighton': 'assets/images/eplLogo/brighton hove albion.svg',
      'Brentford': 'assets/images/eplLogo/Brentford FC logo vector.svg',
      'Bournemouth': 'assets/images/eplLogo/Bournemouth logo - Brandlogos.net.svg',
      'Crystal-Palace': 'assets/images/eplLogo/Crystal Palace FC logo - Brandlogos.net.svg',
      'Everton': 'assets/images/eplLogo/Everton FC logo - Brandlogos.net.svg',
      'Fulham': 'assets/images/eplLogo/fulham-fc-logo.svg',
      'Liverpool': 'assets/images/eplLogo/Liverpool Football Club logo - Brandlogos.net.svg',
      'Manchester-City': 'assets/images/eplLogo/Manchester City FC logo.svg',
      'Manchester-United': 'assets/images/eplLogo/Manchester United F.C. logo - Brandlogos.net.svg',
      'Newcastle-United': 'assets/images/eplLogo/Newcastle United FC logo - Brandlogos.net.svg',
      'Tottenham-Hotspur': 'assets/images/eplLogo/tottenham-hotspur-fc-logo.png',
      'West-Ham-United': 'assets/images/eplLogo/West Ham United FC logo - Brandlogos.net.svg',
      'Aston-Villa': 'assets/images/eplLogo/aston-villa-logo.svg',
      'Leicester-City': 'assets/images/eplLogo/Leicester City FC logo - Brandlogos.net.svg',
      'Leeds-United': 'assets/images/eplLogo/leeds-united-fc.svg',
      'Nottingham-Forest': 'assets/images/eplLogo/Nottingham Forest logo.svg',
      'Southampton': 'assets/images/eplLogo/Southampton FC logo.svg',
      'Wolverhampton-Wanderers': 'assets/images/eplLogo/Wolverhampton Wanderers FC logo.svg',
    };

    return imageMappings[teamId] ?? 'assets/images/eplLogo/Premier League 2007-2016 logo - Brandlogos.net.svg';
  }

  // Helper method to get display name for a team ID
  static String getDisplayName(String teamId) {
    final team = teams.firstWhere(
          (t) => t['id'] == teamId,
      orElse: () => {'id': teamId, 'name': teamId},
    );
    return team['name']!;
  }

  // Helper method to check if image is SVG
  static bool isSvgImage(String imageUrl) {
    return imageUrl.toLowerCase().endsWith('.svg');
  }

  // Helper to get team ID from display name
  static String? getTeamId(String displayName) {
    try {
      final team = teams.firstWhere(
            (t) => t['name']?.toLowerCase() == displayName.toLowerCase(),
      );
      return team['id'];
    } catch (_) {
      return null;
    }
  }
}

// Country code mappings
class CountryConstants {
  static const Map<String, String> countryNames = {
    'eng': 'England',
    'fr': 'France',
    'br': 'Brazil',
    'es': 'Spain',
    'ie': 'Ireland',
    'pt': 'Portugal',
    'nl': 'Netherlands',
    'ng': 'Nigeria',
    'be': 'Belgium',
    'de': 'Germany',
    'ar': 'Argentina',
    'sct': 'Scotland',
    'wls': 'Wales',
    'gh': 'Ghana',
    'ci': 'Ivory Coast',
    'se': 'Sweden',
    'dk': 'Denmark',
    'no': 'Norway',
    'ch': 'Switzerland',
    'pl': 'Poland',
    'ua': 'Ukraine',
    'rs': 'Serbia',
    'hr': 'Croatia',
    'jp': 'Japan',
    'kr': 'South Korea',
    'uy': 'Uruguay',
    'sn': 'Senegal',
    'cm': 'Cameroon',
    'ml': 'Mali',
    'it': 'Italy',
  };

  // Helper to get full country name from code
  static String getCountryName(String code) {
    final lowerCode = code.toLowerCase().trim();
    return countryNames[lowerCode] ?? code.toUpperCase();
  }

  // Helper to parse nation string "code NAME" -> display name
  static String? parseNationString(String? nation) {
    if (nation == null || nation.isEmpty) return null;

    final parts = nation.split(' ');
    if (parts.length >= 2) {
      // Return the full name part
      return parts.sublist(1).join(' ');
    }

    // If just a code, try to look it up
    return getCountryName(parts[0]);
  }

  // Helper to get flag asset path
  static String getFlagAsset(String? nationCode) {
    if (nationCode == null || nationCode.isEmpty) {
      return 'assets/images/country-flags-main/svg/un.svg'; // Default UN flag
    }

    final code = nationCode.toLowerCase().trim();
    return 'assets/images/country-flags-main/svg/$code.svg';
  }
}