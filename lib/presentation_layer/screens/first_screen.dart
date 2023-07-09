import 'package:breaking_bad/business_logic_layer/cubit/character_cubit/all_character_cubit.dart';
import 'package:breaking_bad/business_logic_layer/cubit/character_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);


  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {


  List<String> items = [
    'All Characters',
    'Better Call Saul Characters',
  ];

  DropdownMenuItem<String> buildDropDownItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 19, color: Colors.grey),
        ),
      );

  String? dropDownItemValue;
@override
  void initState() {
  dropDownItemValue=items.first;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CharacterCubit, CharacterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<CharacterCubit>(context);

        return Scaffold(
            appBar: AppBar(
              title: Text('First'),
            ),
            body: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropDownItemValue,
                  items: items.map(buildDropDownItem).toList(),
                  onChanged: ( value) => setState(() =>dropDownItemValue=value)
                  ,
                ),
              ),
            )
            /*
          Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${cubit.counter}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: MyColors.yellow,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        cubit.counter++;
                      });
                    },
                    child: Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: MyColors.yellow,
                      ),
                      child: Center(
                        child: Text(
                          'ADD ONE INSTANCE',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/second',
                      );
                    },
                    child: Container(
                      width: 220,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: MyColors.yellow,
                      ),
                      child: Center(
                        child: Text(
                          'GO TO SECOND SCREEN',
                        ),
                      ),
                    ),
                  ),
                ]),
          ),

           */
            );
      },
    );
  }
}
