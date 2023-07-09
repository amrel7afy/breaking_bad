import '../../../data_layer/models/character_model.dart';

abstract class GetBetterCallSaulStates {}

class GetBetterCallSaulInitialState extends GetBetterCallSaulStates {}

class GetBetterCallSaulSuccessState extends GetBetterCallSaulStates {
  final List<CharacterModel> characters;

  GetBetterCallSaulSuccessState(this.characters);
}

class GetBetterCallSaulErrorState extends GetBetterCallSaulStates {
  final String error;

  GetBetterCallSaulErrorState(this.error);
}