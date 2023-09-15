import 'package:flutter/material.dart';

import 'package:pokeapps/http/get_list_pokemon.dart';
import 'package:pokeapps/model/list_pokemon.dart';
import 'package:pokeapps/model/pokemon.dart';
import 'package:pokeapps/utils/card_tile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LoadDataPokemon loadData = LoadDataPokemon();

  TextEditingController _searchController = TextEditingController();

  List<Pokemon> isPokemonIsReal(List<Pokemon> pokemon, String contain) {
    List<Pokemon> poke = [];

    pokemon.forEach((element) {
      if ((element.name.toLowerCase()).contains(contain)) {
        print('add');
        poke.add(element);
      }
    });
    poke.forEach((element) {
      print(element.name);
    });
    print('selesai');
    return poke;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    // TitleSubTitleTile & sub-TitleSubTitleTile
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Column(
                        children: [
                          TitleSubTitleTile(),

                          // TextField
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: TextField(
                              controller: _searchController,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (value) => setState(() {}),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                suffixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // card view
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: FutureBuilder<ListPokemon>(
                        future: loadData.loadApiPokemon(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  "failed to load data b'cause: ${snapshot.error}"),
                            );
                          } else {
                            List<Pokemon> pokemon = snapshot.data!.pokemon;
                            return GridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 25,
                              crossAxisSpacing: 25,
                              childAspectRatio: 2 / 3,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 30),
                              children: (_searchController.text.isNotEmpty)
                                  ? isPokemonIsReal(
                                          pokemon, _searchController.text)
                                      .map(
                                        (e) => CardListTile(pokemon: e),
                                      )
                                      .toList()
                                  : pokemon
                                      .map((e) => CardListTile(pokemon: e))
                                      .toList(),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // child: Container(
        //   child: Column(
        //     children: [
        //       Container(
        //         height: 100,
        //         width: double.infinity,
        //         decoration: BoxDecoration(),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(
        //               'INFORMASI POKEMON'.toUpperCase(),
        //               style: TextStyle(
        //                 fontSize: 20,
        //                 color: Colors.black,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 8),
        //         child: TextField(
        //           controller: _searchController,
        //           textInputAction: TextInputAction.done,
        //           decoration: InputDecoration(
        //             suffixIcon: IconButton(
        //               icon: Icon(Icons.search),
        //               onPressed: () => setState(() {}),
        //             ),
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(10),
        //             ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(height: 30),
        //       FutureBuilder<ListPokemon>(
        //         future: loadData.loadApiPokemon(),
        //         builder: (context, snapshot) {
        //           if (snapshot.connectionState == ConnectionState.waiting) {
        //             return Center(child: CircularProgressIndicator());
        //           } else if (snapshot.hasError) {
        //             print(snapshot.error);
        //             return Center(child: Text('Error: ${snapshot.error}'));
        //           } else {
        //             List<Pokemon> pokemon = snapshot.data!.pokemon;
        //             return Expanded(child: GridViewTile(pokemon, context));
        //           }
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  GridView GridViewTile(List<Pokemon> pokemon, BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      crossAxisCount: 2,
      crossAxisSpacing: 25,
      mainAxisSpacing: 25,
      physics: BouncingScrollPhysics(),
      childAspectRatio: 2 / 3,
      children: (_searchController.text.isNotEmpty)
          ? isPokemonIsReal(pokemon, _searchController.text)
              .map(
                (e) => CardListTile(pokemon: e),
              )
              .toList()
          : pokemon.map((e) => CardListTile(pokemon: e)).toList(),
    );
  }
}

class TitleSubTitleTile extends StatelessWidget {
  const TitleSubTitleTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(children: [
        Text(
          'POKEDEX POKEMON',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'panton',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'bernostalgia dengan mencari informasi\ntentang pokemon',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'panton',
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ]),
    );
  }
}
