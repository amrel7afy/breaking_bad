import 'package:breaking_bad/business_logic_layer/cubit/character_cubit/all_character_cubit.dart';
import 'package:breaking_bad/business_logic_layer/cubit/character_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/my_colors.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterCubit, CharacterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<CharacterCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Second'),
          ),
          body: Center(
            child: Text(
              '${cubit.counter}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: MyColors.yellow,
              ),
            ),
          ),
        );
      },
    );
  }
}
