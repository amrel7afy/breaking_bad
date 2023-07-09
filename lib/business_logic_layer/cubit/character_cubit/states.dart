import '../../../data_layer/models/character_model.dart';
import '../../../data_layer/models/quote_model.dart';

abstract class CharacterStates {}

class CharacterInitialState extends CharacterStates {}

class CharactersGetSuccessState extends CharacterStates {
  final List<CharacterModel> characters;

  CharactersGetSuccessState(this.characters);
}

class CharactersGetErrorState extends CharacterStates {
  final String error;

  CharactersGetErrorState(this.error);
}

class CharacterGetQuotesSuccessState extends CharacterStates {
  final List<Quote> quotes;

  CharacterGetQuotesSuccessState(this.quotes);
}

class CharacterGetQuotesErrorState extends CharacterStates {
  final String error;

  CharacterGetQuotesErrorState(this.error);
}

