import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:dio/dio.dart' as d;

/// A Class to access the functionality of API
class DioClient {
  /// Constructor for the DioClient class
  DioClient() {
    dio = d.Dio();
  }

  /// Instance of a dio class to call the API
  late final d.Dio dio;

  /// Call the method to get the response
  Future<Response> request() async {
    // GraphQL url for calling the API
    const url = 'https://beta.pokeapi.co/graphql/v1beta';

    // Query to use while fetching data from GraphQL
    const data =
        '''{"query":"query getItems{pokemon_v2_pokemon(limit: 30){id, name, pokemon_v2_pokemontypes{pokemon_v2_type{name},}, },}","variables":{}}''';

    // Image Url to get the pokemon image
    const imgUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon';
    try {
      final response = await dio.post(url, data: data);
      final pokemonData = response.data['data']['pokemon_v2_pokemon'] as List;
      // Iterating through the response to add imageURL
      final jsonData = pokemonData.map(
        (e) {
          final element = e as Map;
          final id = element['id'];
          // Adding the image field for the Pokemon
          element['image'] = '$imgUrl/$id.png';
          return element;
        },
      ).toList();
      // Returning the response
      return Response(body: jsonEncode(jsonData));
    } catch (ex) {
      return Response(
        statusCode: 500,
        body: ex.toString(),
      );
    }
  }
}
