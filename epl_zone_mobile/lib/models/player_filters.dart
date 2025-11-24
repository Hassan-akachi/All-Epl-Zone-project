// lib/models/player_filters.dart
class PlayerFilters {
  final String? team;
  final String? position;
  final String? nation;
  final String? name;

  PlayerFilters({
    this.team,
    this.position,
    this.nation,
    this.name,
  });

  Map<String, String> toQueryParams() {
    final params = <String, String>{};
    if (team != null) params['team'] = team!;
    if (position != null) params['position'] = position!;
    if (nation != null) params['nation'] = nation!;
    if (name != null) params['name'] = name!;
    return params;
  }
}