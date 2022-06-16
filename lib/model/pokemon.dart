import 'dart:convert';

List<Pokemon> pokemonFromJson(String str) =>
    List<Pokemon>.from(json.decode(str).map((x) => Pokemon.fromJson(x)));

String pokemonToJson(List<Pokemon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pokemon {
  final String name;
  final String url;

  Pokemon({required this.name, required this.url});

  Pokemon copyWith({
    String? name,
    String? url,
  }) =>
      Pokemon(
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
