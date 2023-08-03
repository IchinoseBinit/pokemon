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

  /// Creating a list to store the pokemon data
  List<Pokemon> pokemonList = [];

  /// Expiry time for cache
  final expiryTimeInMins = 59;

  /// Use this method to get the data of the Pokemon
  Future fetchPokemons() async {
    try {
      final box = await Hive.openBox(HiveConstants.pokemonBox);
      final hiveData = box.get(HiveConstants.pokemonData, defaultValue: null);
      // Checking whether the data has been cached previously
      if (hiveData == null) {
        // If null, means data has not been cached
        // Get data from API
        final response = await getApiRequest(box);
        // Update the state from the response
        _updateState(List.from(jsonDecode(response.data)));
      } else {
        // Using patterns to destruct values
        final (hasExpired, list) = getExpiredStatusAndData(hiveData);
        if (hasExpired) {
          // If the cached data has been for more than 1 hour, recall the API
          final response = await getApiRequest(box);
          _updateState(List.from(jsonDecode(response.data)));
        } else {
          // If the cached data has not expired, use the data to update the list
          _updateState(list);
        }
      }
      // Update the variable with the value of state (For search functionality)
      pokemonList = state;
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  /// Using Records to create composite values
  (bool hasExpired, List data) getExpiredStatusAndData(dynamic hiveData) {
    // Get the data from hive and decode it
    final data = jsonDecode(hiveData);
    // Convert the dateTime into a datetime instance
    final cachedDateTime = DateTime.parse(data["dateTime"]);
    // Check whether the cache data has expired
    final hasExpired =
        DateTime.now().difference(cachedDateTime).inMinutes > expiryTimeInMins;
        // Return composite value, i.e. whether the value has expired (bool) and the data itself
    return (hasExpired, data["data"]);
  }


  /// Updates the state by converting the given list of map to instance of
  _updateState(List list) {
    state = list.map((e) => Pokemon.fromJson(e)).toList();
  }

  /// Calls the API and updates the hive box
  Future<Response> getApiRequest(Box box) async {
    try {
      // Call the DioClient singleton class for request
      final response = await DioClient().request();
      // Create a new map with the dateTime instance to use it for checking the cache is valid or not
      final data = {
        "dateTime": DateTime.now().toString(),
        "data": jsonDecode(response.data),
      };
      // Put the data in the hive box
      box.put(HiveConstants.pokemonData, jsonEncode(data));

      return response;
    } catch (ex) {
      rethrow;
    }
  }

  /// Use this method to filter the pokemon
  searchPokemon(String value) {
    // If the value is empty, populate the state with every pokemon data
    if (value.trim().isEmpty) {
      state = pokemonList;
    } else {
      // Check and filter those pokemon who contains the letters searched in the name
      state = pokemonList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }
}
