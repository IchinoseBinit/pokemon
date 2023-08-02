import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/provider/pokemon_provider.dart';
import '/view/home/widgets/pokemon_card.dart';
import '/widgets/body_template.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/future_resolver.dart';
import '/widgets/general_text_field.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final widgets = FutureResolver();
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Pokemons",
        disableLeading: true,
      ),
      body: BodyTemplate(
        child: Consumer(builder: (context, ref, child) {
          return ref.watch(pokemonFutureProvider).when(
              data: (data) {
                return Column(
                  children: [
                    GeneralTextField(
                      hintText: "Search",
                      onChanged: (v) {
                        ref.read(pokemonProvider.notifier).searchPokemon(v);
                      },
                      preferWidget: const Icon(Icons.search),
                      removePrefixIconDivider: true,
                      keywordType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Builder(
                      builder: (context) {
                        final pokemonList = ref.watch(pokemonProvider);
                        if (pokemonList.isEmpty) {
                          return widgets.showError(message: "Search results not found");
                        }
                        return Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) =>
                                PokemonCard(pokemon: pokemonList[index]),
                            separatorBuilder: (_, __) => SizedBox(
                              height: 24.h,
                            ),
                            itemCount: pokemonList.length,
                            primary: false,
                            shrinkWrap: true,
                          ),
                        );
                      }
                    ),
                  ],
                );
              },
              error: (_, __) {
                return widgets.showError();
              },
              loading: () => widgets.showLoading());
        }),
      ),
    );
  }
}
