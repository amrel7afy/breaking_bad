class CharacterModel {
  late final int char_id;
  late final String name;
  late final String birthday;
  late final List<dynamic> occupation;
  late final String img;
  late final String status;
  late final String nickname;
  late final List<dynamic> appearance;
  late final String portrayed;
  late final String category;
  late final List<dynamic> better_call_saul_appearance;

  CharacterModel.formJson(Map<String, dynamic> json) {
    char_id = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    occupation = json['occupation'];
    img = json['img'];
    status = json['status'];
    nickname = json['nickname'];
    appearance = json['appearance'];
    portrayed = json['portrayed'];
    category = json['category'];
    better_call_saul_appearance = json['better_call_saul_appearance'];
  }

  Map<String, dynamic> toMap() {
    return {
      'char_id': char_id,
      'name': name,
      'birthday': birthday,
      'occupation': occupation,
      'img': img,
      'status': status,
      'nickname': nickname,
      'appearance': appearance,
      'portrayed': portrayed,
      'category': category,
      'better_call_saul_appearance': better_call_saul_appearance,
    };
  }
}

