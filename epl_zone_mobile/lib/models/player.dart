// lib/features/player/models/player.dart

class Player {
  final String id;
  final String player;
  final String? nation;
  final String pos;
  final int? age;
  final int mp;
  final int starts;
  final double? min;
  final double? gls;
  final double? ast;
  final double? pk;
  final double? crdy;
  final double? crdr;
  final double? xg;
  final double? xag;
  final String team;

  Player({
    required this.id,
    required this.player,
    this.nation,
    required this.pos,
    this.age,
    required this.mp,
    required this.starts,
    this.min,
    this.gls,
    this.ast,
    this.pk,
    this.crdy,
    this.crdr,
    this.xg,
    this.xag,
    required this.team,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as String,
      player: json['player'] as String,
      nation: json['nation'] as String?,
      pos: json['pos'] as String,
      age: json['age'] as int?,
      mp: json['mp'] as int? ?? 0,
      starts: json['starts'] as int? ?? 0,
      min: _toDouble(json['min']),
      gls: _toDouble(json['gls']),
      ast: _toDouble(json['ast']),
      pk: _toDouble(json['pk']),
      crdy: _toDouble(json['crdy']),
      crdr: _toDouble(json['crdr']),
      xg: _toDouble(json['xg']),
      xag: _toDouble(json['xag']),
      team: json['team'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'player': player,
      'nation': nation,
      'pos': pos,
      'age': age,
      'mp': mp,
      'starts': starts,
      'min': min,
      'gls': gls,
      'ast': ast,
      'pk': pk,
      'crdy': crdy,
      'crdr': crdr,
      'xg': xg,
      'xag': xag,
      'team': team,
    };
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  // Helper method to get formatted nation name
  String? get nationName {
    if (nation == null) return null;
    // Extract country name from format "code NAME"
    // e.g., "fr FRA" -> "France", "eng ENG" -> "England"
    final parts = nation!.split(' ');
    if (parts.length >= 2) {
      return parts.sublist(1).join(' ');
    }
    return nation;
  }

  // Helper method to get nation code
  String? get nationCode {
    if (nation == null) return null;
    final parts = nation!.split(' ');
    if (parts.isNotEmpty) {
      return parts[0];
    }
    return null;
  }

  Player copyWith({
    String? id,
    String? player,
    String? nation,
    String? pos,
    int? age,
    int? mp,
    int? starts,
    double? min,
    double? gls,
    double? ast,
    double? pk,
    double? crdy,
    double? crdr,
    double? xg,
    double? xag,
    String? team,
  }) {
    return Player(
      id: id ?? this.id,
      player: player ?? this.player,
      nation: nation ?? this.nation,
      pos: pos ?? this.pos,
      age: age ?? this.age,
      mp: mp ?? this.mp,
      starts: starts ?? this.starts,
      min: min ?? this.min,
      gls: gls ?? this.gls,
      ast: ast ?? this.ast,
      pk: pk ?? this.pk,
      crdy: crdy ?? this.crdy,
      crdr: crdr ?? this.crdr,
      xg: xg ?? this.xg,
      xag: xag ?? this.xag,
      team: team ?? this.team,
    );
  }
}
