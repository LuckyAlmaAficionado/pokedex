import 'package:flutter/material.dart';
import 'package:pokeapps/http/get_list_pokemon.dart';
import 'package:pokeapps/model/list_pokemon.dart';
import 'package:pokeapps/model/pokemon.dart';

// ignore: must_be_immutable
class DetailPokemon extends StatelessWidget {
  int id;
  DetailPokemon({
    super.key,
    required this.id,
  });

  LoadDataPokemon loadPokemon = LoadDataPokemon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<ListPokemon>(
          future: loadPokemon.loadApiPokemon(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('failed to load data ${snapshot.error}'));
            } else {
              var pokemon = snapshot.data!.pokemon;
              Pokemon? poke = pokemon.firstWhere((element) => element.id == id);
              if (poke.name.isNotEmpty) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        child: Image.network(
                          poke.img,
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      InfoTile('name', poke.name),
                      InfoTile('egg', poke.egg),
                      InfoTile('height', poke.height),
                      InfoTile('weight', poke.weight),
                      InfoTile('spawn time', poke.spawnTime),
                    ],
                  ),
                );
              } else {
                return Text('Pokemon not found');
              }
            }
          },
        ),
      ),
    );
  }

  Container InfoTile(String title, String info) {
    return Container(
      margin: EdgeInsets.only(top: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontFamily: 'panton',
            ),
          ),
          Text(
            info,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 'panton',
            ),
          ),
        ],
      ),
    );
  }
}
