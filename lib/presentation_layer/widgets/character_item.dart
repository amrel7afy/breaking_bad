import 'package:breaking_bad/constants/my_colors.dart';
import 'package:breaking_bad/data_layer/models/character_model.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  CharacterModel characterModel;

  CharacterItem({Key? key, required this.characterModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: MyColors.white, borderRadius: BorderRadius.circular(10)),
      child: Hero(
        tag: characterModel.char_id,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/characterDetails',
                  arguments: characterModel);
            },
            child: GridTile(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: MyColors.grey,
                child: characterModel.img.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        placeholder: 'assets/images/loading.gif',
                        image: characterModel.img,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Text(
                          'No Founded Image ',
                          style: TextStyle(color: MyColors.white),
                        ),
                      ),
              ),
              footer: Container(
                alignment: AlignmentDirectional.center,
                color: Colors.black45,
                child: Text(
                  '${characterModel.name}',
                  style: TextStyle(
                      height: 1.5,
                      color: MyColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
