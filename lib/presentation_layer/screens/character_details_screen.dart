import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/business_logic_layer/cubit/character_cubit/all_character_cubit.dart';
import 'package:breaking_bad/business_logic_layer/cubit/character_cubit/states.dart';
import 'package:breaking_bad/constants/my_colors.dart';
import 'package:breaking_bad/data_layer/models/character_model.dart';
import 'package:breaking_bad/data_layer/models/quote_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel characterModel;

  CharacterDetailsScreen({Key? key, required this.characterModel})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.grey,
      expandedHeight: 600,
      titleSpacing: 0.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          characterModel.nickname,
          style: TextStyle(color: MyColors.white, fontSize: 25),
        ),
        // ممكن [App Bar]
        background: Hero(
          tag: characterModel.char_id,
          child: Image.network(
            characterModel.img,
            fit: BoxFit.cover,
          ),
        ),
        stretchModes: <StretchMode>[
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
          StretchMode.blurBackground
        ],
      ),
    );
  }

  Widget checkIfQuotesAreLoaded(CharacterStates state) {
    if (state is CharacterGetQuotesSuccessState) {
      return displayRandomQuoteOrEmptyContainer(state);
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: MyColors.yellow,
        ),
      );
    }
  }

  Widget displayRandomQuoteOrEmptyContainer(state) {
    List<Quote> quotes = state.quotes;
    late int randomQuoteIndex;
    if (quotes.length > 1) {
      randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: Container(
          margin: EdgeInsets.all(14),
          child: DefaultTextStyle(
            style: TextStyle(
              color: MyColors.white,
              fontSize: 20,
              shadows: [
                Shadow(
                  blurRadius: 7,
                  color: MyColors.yellow,
                ),
              ],
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                FlickerAnimatedText(
                  quotes[randomQuoteIndex].quote,
                  speed: Duration(seconds: 2),
                )
              ],
            ),
          ),
        ),
      );
    } else if (quotes.length == 1) {
      return Center(
        child: Container(
          margin: EdgeInsets.all(14),
          child: DefaultTextStyle(
            style: TextStyle(
              color: MyColors.white,
              fontSize: 20,
              shadows: [
                Shadow(
                  blurRadius: 7,
                  color: MyColors.yellow,
                ),
              ],
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                FlickerAnimatedText(
                  quotes[0].quote,
                  speed: Duration(seconds: 2),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getAllQuotes(characterModel.name);
    //لو عملت استدعاء للميثود هنا هيعمل استدعاء ليها مرة واحدة وانا ب build
    /*
    لكن لو عملت استدعاء ليها تحت عند ال bloc builder  هيعملها  call كل شوية
     */
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 14, right: 14, top: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildCharacterInfoItem(
                              text: 'Job',
                              value: characterModel.occupation.join(' / '),
                              endIndent: width * 0.83),
                          buildCharacterInfoItem(
                              text: 'Appeared In',
                              value: characterModel.category,
                              endIndent: width * 0.64),
                          buildCharacterInfoItem(
                              text: 'Seasons',
                              value: characterModel.appearance.join(' / '),
                              endIndent: width * 0.72),
                          buildCharacterInfoItem(
                              text: 'Status',
                              value: characterModel.status,
                              endIndent: width * 0.76),
                          buildCharacterInfoItem(
                              text: 'Actor/Actress',
                              value: characterModel.portrayed,
                              endIndent: width * 0.61),
                          characterModel.better_call_saul_appearance.isEmpty
                              ? Container()
                              : buildCharacterInfoItem(
                                  text: 'Better Call Soul Seasons',
                                  value: characterModel
                                      .better_call_saul_appearance
                                      .join(' / '),
                                  endIndent: width * 0.39),
                        ],
                      ),
                    ),
                    BlocBuilder<CharacterCubit, CharacterStates>(
                        builder: (context, state) {
                      return checkIfQuotesAreLoaded(state);
                    }),
                    SizedBox(
                      height: 500,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildCharacterInfoItem(
      {required String text,
      required String value,
      required double endIndent}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '$text: ',
                style: TextStyle(
                    color: MyColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: value,
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Divider(
          endIndent: endIndent,
          height: 30,
          thickness: 3,
          color: MyColors.yellow,
        )
      ],
    );
  }
}
