// lib/core/network/api_endpoints.dart
class ApiEndpoints {
  static const String playerbaseUrl ="http://10.56.134.17:8080";// "http://localhost:8080"; //"ip addr" to check ip of computer to test on real device
  static const String authbaseUrl = "http://10.56.134.17:4000";//"http://localhost:4000";

  // Auth Endpoints
  static const String register = "/authentication/register";
  static const String login = "/authentication/login";
  static const String googleLogin = "/authentication/google-login";
  static const String profile = "/profile";

  // Player Endpoints
  static const String players = "/api/v1/players";
  static String playerById(String id) => "/api/v1/players/$id";
  static const String topScorers = "/api/v1/players/top-scorers";
  static String teamTopScorers(String team) => "/api/v1/players/teams/$team/top-scorers";
  static const String searchPlayers = "/api/v1/players/search";

  // Full URLs
  static String get registerUrl => "$authbaseUrl$register";
  static String get loginUrl => "$authbaseUrl$login";
  static String get googleLoginUrl => "$authbaseUrl$googleLogin";
  static String get profileUrl => "$authbaseUrl$profile";
  static String get playersUrl => "$playerbaseUrl$players";
// Helper method to get full URL
  static String getAuthUrl(String endpoint) => "$authbaseUrl$endpoint";

  static String getPlayerUrl(String endpoint) => "$authbaseUrl$endpoint";

  // Query parameter builders
  static String buildQueryParams(Map<String, String> params) {
    if (params.isEmpty) return '';
    final query = params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
    return '?$query';
  }
}