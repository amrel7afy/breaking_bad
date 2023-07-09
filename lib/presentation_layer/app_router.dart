import 'package:breaking_bad/business_logic_layer/cubit/character_cubit/all_character_cubit.dart';
import 'package:breaking_bad/data_layer/models/character_model.dart';
import 'package:breaking_bad/data_layer/repository/character_repo.dart';
import 'package:breaking_bad/data_layer/web_services/character_webservices.dart';
import 'package:breaking_bad/presentation_layer/screens/character_details_screen.dart';
import 'package:breaking_bad/presentation_layer/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic_layer/cubit/character_cubit/better_call_saul_cubit.dart';
import '../constants/strings.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharacterCubit cubit;
  late BetterCallSaulCubit betterCallSaulCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterWebServices());
    cubit = CharacterCubit(characterRepository);
    betterCallSaulCubit = BetterCallSaulCubit(characterRepository);
  }


  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case showCharacters:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider.value(value: cubit),
                  BlocProvider(
                      create: (BuildContext context) => betterCallSaulCubit)
                ], child: CharactersScreen()));
      case characterDetails:
        final CharacterModel character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (BuildContext context) =>
                      CharacterCubit(characterRepository),
                  child: CharacterDetailsScreen(
                    characterModel: character,
                  ),
                ));
      // case '/':
      //   return MaterialPageRoute(
      //       builder: (context) =>
      //           BlocProvider.value(value: cubit, child: FirstScreen()));
      // case '/second':
      //   return MaterialPageRoute(
      //       builder: (context) =>
      //           BlocProvider.value(value: cubit, child: SecondScreen()));
      default:
        return null;
    }
  }
}
