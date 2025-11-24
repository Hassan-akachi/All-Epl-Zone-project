// lib/models/player.dart
class Player {
final String id;
final String player;
final String nation;
final String pos;
final int age;
final int mp;
final int starts;
final double min;
final double gls;
final double ast;
final double pk;
final double crdy;
final double crdr;
final double xg;
final double xag;
final String team;

Player({
required this.id,
required this.player,
required this.nation,
required this.pos,
required this.age,
required this.mp,
required this.starts,
required this.min,
required this.gls,
required this.ast,
required this.pk,
required this.crdy,
required this.crdr,
required this.xg,
required this.xag,
required this.team,
});

factory Player.fromJson(Map<String, dynamic> json) {
return Player(
id: json['id'] ?? '',
player: json['player'] ?? '',
nation: json['nation'] ?? '',
pos: json['pos'] ?? '',
age: json['age'] ?? 0,
mp: json['mp'] ?? 0,
starts: json['starts'] ?? 0,
min: (json['min'] ?? 0).toDouble(),
gls: (json['gls'] ?? 0).toDouble(),
ast: (json['ast'] ?? 0).toDouble(),
pk: (json['pk'] ?? 0).toDouble(),
crdy: (json['crdy'] ?? 0).toDouble(),
crdr: (json['crdr'] ?? 0).toDouble(),
xg: (json['xg'] ?? 0).toDouble(),
xag: (json['xag'] ?? 0).toDouble(),
team: json['team'] ?? '',
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
}