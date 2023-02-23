import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/models/pokemon.dart';

import '../api/pokemon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> pokemons = [];

  initialize() async {
    // final String response = await rootBundle.loadString('mocks/pokemon.json');
    // final data = await json.decode(response);
    List<Map<String, dynamic>> pokeList = [];
    for (var i = 1; i <= 255; i++) {
      var poke = await getPokemon(i);
      pokeList.add(poke ?? {});
    }

    setState(() => pokemons.addAll(pokeList));
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade400,
      body: SafeArea(
        child: Column(
          children: [
            //LOGO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/pokemon.png', width: 150, fit: BoxFit.contain, filterQuality: FilterQuality.medium),
                  Image.asset('assets/pokeball.png', width: 50, fit: BoxFit.contain, filterQuality: FilterQuality.medium),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Search...'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)), color: Color.fromRGBO(240, 240, 240, 1)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 10),
                  child: GridView.count(
                      crossAxisCount: 3,
                      children: pokemons
                          .map((e) => Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          e['sprites']?['versions']?['generation-i']?['yellow']?['front_default'] ?? '',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(e['name'].toString().capitalize()),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(e['id'].toString().padLeft(3, '0'), style: TextStyle(color: Colors.grey.shade500)),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
