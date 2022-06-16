import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/pokemoncontroller.dart';
import 'package:test/views/pokemondetails.dart';

// ignore: must_be_immutable
class Home extends GetView<PokemonController> {
  Home({Key? key}) : super(key: key);
  @override
  final PokemonController controller = Get.put(PokemonController());
  TextEditingController txtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("¡Atrapalos ya!"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.pokemonList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.pokemonList.length) {
                        final pokemon = controller.pokemonList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 8,
                            child: SizedBox(
                              height: 80,
                              child: Center(
                                child: ListTile(
                                  title: SizedBox(
                                      child: Text(pokemon.name.toUpperCase())),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                  ),
                                  onTap: () => Get.to(() => PokemonDetails(
                                        pokemon,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Center(
                                child: controller.hasmore.value
                                    ? const CircularProgressIndicator()
                                    : const Text('No more pokemons')));
                      }
                    }),
              ),
            ),
          ],
        ));
  }
}
