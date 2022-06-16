import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test/model/pokemon.dart';

class RemoteServices {
  static var client = http.Client();
  static int total = 0;
  static Future<List<Pokemon>?> fetchPokemons(
      {int limit = 10, int offset = 0}) async {
    String url =
        // ignore: prefer_adjacent_string_concatenation
        'https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset';
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var json = jsonDecode(jsonString);
        jsonString = jsonEncode(json['results']);
        return pokemonFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString() +
          'Ups!. Something went wrong. Check your connection and try again');
      // Get.snackbar('Error',
      //     'Ups!. Something went wrong. Check your connection and try again',
      //     duration: const Duration(seconds: 5),
      //     snackPosition: SnackPosition.BOTTOM);

      return null;
    }
  }
}
