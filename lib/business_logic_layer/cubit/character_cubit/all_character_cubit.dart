import 'package:breaking_bad/business_logic_layer/cubit/character_cubit/states.dart';
import 'package:breaking_bad/data_layer/models/character_model.dart';
import 'package:breaking_bad/data_layer/repository/character_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterCubit extends Cubit<CharacterStates> {
  static CharacterCubit get(context) => BlocProvider.of(context);
  CharacterRepository characterRepository;

  CharacterCubit(this.characterRepository) : super(CharacterInitialState());

  List<CharacterModel> characters = [];
  int counter = 0;
  bool isLoading = false;

  List<CharacterModel> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      this.characters = characters;
      emit(CharactersGetSuccessState(characters));
      print(characters.first);
    }).catchError((error) {
      print('get characters error: ' + error.toString());
      emit(CharactersGetErrorState(error.toString()));
    });
    return characters;
  }

  void getAllQuotes(String name) {
    isLoading = true;
    characterRepository.getAllQuotes(name).then((quotes) {
      print('get quotes');
      emit(CharacterGetQuotesSuccessState(quotes));
      isLoading = false;
    }).catchError((error) {
      print('Get Quote Error: ' + error.toString());
    });
  }
  
  

}
