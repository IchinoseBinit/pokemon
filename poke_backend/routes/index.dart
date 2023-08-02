import 'package:dart_frog/dart_frog.dart';
import 'package:poke_backend/utils/dio_client.dart';

Future<Response> onRequest(RequestContext context) async {
  final pokeApi = await (await DioClient().request()).body();
  return Response(body: pokeApi);
}
