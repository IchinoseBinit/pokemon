import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/constants/hive_constants.dart';
import '/model/pokemon.dart';
import '/utils/dio_client.dart';

final pokemonProvider =
    StateNotifierProvider<PokemonProvider, List<Pokemon>>((ref) {
  return PokemonProvider();
});

final pokemonFutureProvider = FutureProvider<List<Pokemon>>((ref) async {
  final provider = ref.watch(pokemonProvider.notifier);
  await provider.fetchPokemons();
  return ref.read(pokemonProvider);
});

class PokemonProvider extends StateNotifier<List<Pokemon>> {
  PokemonProvider() : super([]);

  List<Pokemon> pokemonList = [];

  final expiryTimeInMins = 59;

  Future fetchPokemons() async {
    try {
      final box = await Hive.openBox(HiveConstants.pokemonBox);
      final hiveData = box.get(HiveConstants.pokemonData, defaultValue: null);
      if (hiveData == null) {
        final response = await getApiRequest(box);
        updateState(List.from(jsonDecode(response.data)));
      } else {
        // Using patterns to destruct values
        final (hasExpired, list) = getExpiredStatusAndData(hiveData);
        if (hasExpired) {
          final response = await getApiRequest(box);
          updateState(List.from(jsonDecode(response.data)));
        } else {
          updateState(list);
        }
      }
      pokemonList = state;
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  /// Using Records to create composite values
  (bool hasExpired, List data) getExpiredStatusAndData(dynamic hiveData) {
    final data = jsonDecode(hiveData);
    final cachedDateTime = DateTime.parse(data["dateTime"]);
    final hasExpired =
        DateTime.now().difference(cachedDateTime).inMinutes > expiryTimeInMins;
    return (hasExpired, data["data"]);
  }

  updateState(List list) {
    state = list.map((e) => Pokemon.fromJson(e)).toList();
  }

  Future<Response> getApiRequest(Box box) async {
    try {
      final response = await DioClient().request();
      final data = {
        "dateTime": DateTime.now().toString(),
        "data": jsonDecode(response.data),
      };
      box.put(HiveConstants.pokemonData, jsonEncode(data));

      return response;
    } catch (ex) {
      rethrow;
    }
  }

  searchPokemon(String value) {
    if (value.trim().isEmpty) {
      state = pokemonList;
    } else {
      state = pokemonList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }
}
