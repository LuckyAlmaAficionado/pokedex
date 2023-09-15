import 'dart:convert';

import 'package:pokeapps/model/list_pokemon.dart';
import 'package:http/http.dart' as http;

class LoadDataPokemon {
  Future<ListPokemon> loadApiPokemon() async {
    final response = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"));

    print('loadApiPokemon ${response.statusCode}');
    if (response.statusCode == 200) {
      return ListPokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load pokemon');
    }
  }
}
