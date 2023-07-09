
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_layer/models/character_model.dart';
import '../../../data_layer/repository/character_repo.dart';
import 'better_call_saul_state.dart';

class BetterCallSaulCubit extends Cubit<GetBetterCallSaulStates>{

  CharacterRepository characterRepository;
  List<CharacterModel> betterCallSaulCharacters = [];
  BetterCallSaulCubit(this.characterRepository):super(GetBetterCallSaulInitialState());


  List<CharacterModel> getBetterCallSaulCharacters(){
    characterRepository.getBetterCallSaulCharacters().then((characters) {
      betterCallSaulCharacters=characters;
      emit(GetBetterCallSaulSuccessState(characters));
      print('GetBetterCallSaulSuccessState');
    }
    ).catchError((error){
      print("getBetterCallSaulCharacters Error: "+error.toString());
    });
    return betterCallSaulCharacters;
  }
}



