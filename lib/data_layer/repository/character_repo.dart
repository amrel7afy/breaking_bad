import 'package:breaking_bad/data_layer/models/character_model.dart';
import 'package:breaking_bad/data_layer/models/quote_model.dart';
import 'package:breaking_bad/data_layer/web_services/character_webservices.dart';

class CharacterRepository {
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);

  Future<List<CharacterModel>> getAllCharacters() async {
    final List characters = await characterWebServices.getAllCharacters();
    return characters
        .map((character) => CharacterModel.formJson(character))
        .toList();
  }

  Future<List<Quote>> getAllQuotes(String name) async {
    final List quotes = await characterWebServices.getAllQuotes(name);
    return quotes.map((quote) => Quote.formJson(quote)).toList();
  }



  Future<List<CharacterModel>>getBetterCallSaulCharacters()async {
    final characters=await characterWebServices.getBetterCallSaulCharacters();
    return characters.map((character) => CharacterModel.formJson(character)).toList();
  }
}
