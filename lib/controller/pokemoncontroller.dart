import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:test/model/pokemon.dart';
import 'package:test/services/networkservice.dart';

class PokemonController extends GetxController {
  var isLoading = false.obs;
  final pokemonList = <Pokemon>[].obs;
  final scrollController = ScrollController();
  var hasmore = true.obs;
  final total = 0.obs;
  int offset = 0;
  bool loadedPokemons = false;
  @override
  void onInit() {
    fetchPokemons();
    super.onInit();
    // total.value = (box.hasData('total')) ? box.read('total') : 0;
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        fetchPokemons();
      }
    });
  }

  void fillList(List<Pokemon> list) {
    pokemonList.value = List.from(pokemonList)..addAll(list);
  }

  void fetchPokemons() async {
    try {
      if (isLoading.value) return;
      isLoading(true);
      var pokemons =
          await RemoteServices.fetchPokemons(limit: 10, offset: offset);
      if (pokemons != null) {
        if (pokemons.length % 10 != 0) hasmore(false);
        fillList(pokemons);
        total(RemoteServices.total);
        offset += 10;
      }
      loadedPokemons = true;
    } finally {
      isLoading(false);
    }
  }
}
