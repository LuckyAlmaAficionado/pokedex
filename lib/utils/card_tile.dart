import 'package:flutter/material.dart';

import '../detail_pokemon.dart';
import '../model/pokemon.dart';

// ignore: must_be_immutable
class CardListTile extends StatelessWidget {
  Pokemon pokemon;
  CardListTile({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailPokemon(id: pokemon.id),
      )),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 3,
                blurStyle: BlurStyle.normal,
                offset: Offset(4, -4),
                spreadRadius: 3,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Image.network(
                pokemon.img,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Icon(Icons.error_outline)),
              ),
            ),
            Text(
              pokemon.name.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
