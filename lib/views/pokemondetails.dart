import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/pokemon.dart';

class PokemonDetails extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonDetails(this.pokemon, {Key? key}) : super(key: key);

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  Map<String, dynamic> pokemon = {};
  String imageurl = "";
  static var client = http.Client();
  List<dynamic> stats = [];
  late final Future<String>? myFuture;
  @override
  void initState() {
    myFuture = getData();
    super.initState();
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  Future<String> getData() async {
    var response = await http.get(Uri.parse(widget.pokemon.url));
    pokemon = jsonDecode(response.body);
    log(pokemon['forms'].toString());
    stats = pokemon['stats'];
    response = await http.get(Uri.parse(pokemon['forms'][0]['url']));
    var sprites = jsonDecode(response.body);
    imageurl = sprites['sprites']['front_default'];
    setState(() {});
    return imageurl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(capitalize(widget.pokemon.name)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<String>(
                  future: myFuture,
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Row(children: [
                        Image.network(imageurl),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var stat in stats)
                              Row(
                                children: [
                                  Text(
                                    capitalize(stat['stat']['name'] + ':'),
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    stat['base_stat'].toString(),
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
                          ],
                        )
                      ]);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
