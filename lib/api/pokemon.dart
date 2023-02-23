import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';

Future<Map<String, dynamic>?> getPokemon(int id) async {
  try {
    var response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

    var data = json.decode(response.body);

    return data;
  } catch (e) {
    log(e.toString());
  }
  return null;
}
