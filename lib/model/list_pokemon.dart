import 'package:pokeapps/model/pokemon.dart';

class ListPokemon {
  List<Pokemon> pokemon;

  ListPokemon({
    required this.pokemon,
  });

  factory ListPokemon.fromJson(Map<String, dynamic> json) {
    return ListPokemon(
      pokemon:
          List<Pokemon>.from(json['pokemon'].map((x) => Pokemon.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "pokemon": List<dynamic>.from(pokemon.map((e) => e.toJson())),
      };
}
