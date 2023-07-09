import 'package:breaking_bad/business_logic_layer/cubit/character_cubit/all_character_cubit.dart';
import 'package:breaking_bad/business_logic_layer/cubit/character_cubit/better_call_saul_cubit.dart';
import 'package:breaking_bad/business_logic_layer/cubit/character_cubit/states.dart';
import 'package:breaking_bad/constants/my_colors.dart';
import 'package:breaking_bad/presentation_layer/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../business_logic_layer/cubit/character_cubit/better_call_saul_state.dart';
import '../../data_layer/models/character_model.dart';

class CharactersScreen extends StatefulWidget {
  CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<CharacterModel> _charactersList = [];
  List<CharacterModel> _filteredCharactersList = [];
  List<CharacterModel> _betterCallSaulCharactersList = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  late CharacterCubit _allCharacterCubit;
  late BetterCallSaulCubit _betterCallSaulCubit;

  String? _dropDownItemValue; //<<<<<<<<Drop Down Value>>>>>
  List<String> _items = [
    'All Characters',
    'Better Call Saul Characters',
  ];

  DropdownMenuItem<String> buildDropDownItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, color: MyColors.grey),
        ),
      );

  @override
  void initState() {
    super.initState();
    _allCharacterCubit = BlocProvider.of<CharacterCubit>(context);
    _charactersList = _allCharacterCubit.getAllCharacters();
    _betterCallSaulCubit = BlocProvider.of<BetterCallSaulCubit>(context);
    _betterCallSaulCharactersList =
        _betterCallSaulCubit.getBetterCallSaulCharacters();
    _dropDownItemValue = _items.first;
  }

  Widget buildSearchField() {
    return TextField(
      cursorColor: MyColors.grey,
      controller: _searchController,
      style: TextStyle(color: MyColors.grey, fontSize: 18),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'search for character...',
        hintStyle: TextStyle(color: MyColors.grey, fontSize: 18),
      ),
      onChanged: (inputLetter) {
        _addCharacterToFilteredCharactersList(inputLetter);
      },
    );
  }

  _addCharacterToFilteredCharactersList(String inputLetter) {


    _filteredCharactersList = _charactersList
        .where(
            (character) => character.name.toLowerCase().contains(inputLetter))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _stopSearch();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: MyColors.grey,
          ),
        ),
      ];
    }
    // المفروض كدا لما يضغط عليها يفتح ال search
    else {
      return [
        IconButton(
          onPressed: () {
            _startSearch();
          },
          icon: Icon(Icons.search, color: MyColors.grey),
        ),
      ];
    }
  }

  _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(
        // هنا بقوله وانا بقفل ال route الجديد دا ابقي stopSearch
        onRemove: _stopSearch()));

    setState(() {
      _isSearching = true;
    });
  }

  // الميثود دي مش بنستدعيها الا في مكان واحد بس وهو وانت طالع من الroute بتاع ال search
  _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  Widget buildAppBarTitle() {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: MyColors.yellow,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          
          value: _dropDownItemValue,
          icon: Icon(
            Icons.keyboard_arrow_down_sharp,
            color: MyColors.grey,
          ),
          iconSize: 30,
          borderRadius: BorderRadius.circular(
            20,
          ),
          items: _items
              .map(
                buildDropDownItem,
              )
              .toList(),
          onChanged: (value) => setState(
            () => _dropDownItemValue = value,
          ),
        ),
      ),
    );
  }

  ////////////////
  // الاتنين ميثود الجايين دول معمولين عشان اعرف انا هجيب حجم
  // الليست بتاعت اي list  وعشان اشوف هباصي اي موديل بردو
  int? getListCount() {
    if (_searchController.text.isEmpty &&
        _dropDownItemValue == 'All Characters') {
      return _charactersList.length;
    } else if (_searchController.text.isEmpty &&
        _dropDownItemValue == 'Better Call Saul Characters') {
      return _betterCallSaulCharactersList.length;
    } else {
      return _filteredCharactersList.length;
    }
  }

//---------------------------------------------------------------------

//دي عشان نرجع model للعنصر الواحد اللي هيتعرض في الهوم
// فعلى حسب قيمة ال_searchController و _dropDownItemValue
// هنباصي الموديل من الليست التلاتة ليست بتوعنا

  CharacterModel getCharacterModel(int index) {
    if (_searchController.text.isEmpty &&
        _dropDownItemValue == 'All Characters') {
      // هنا هيبقي الكونترولر فاضي وكمان ال _dropDownItemValue بيساوي اول قيمة
      return _charactersList[index];
    } else if (_searchController.text.isEmpty &&
        _dropDownItemValue == 'Better Call Saul Characters') {
      return _betterCallSaulCharactersList[index];
    } else {
      return _filteredCharactersList[index];
    }
  }
//---------------------------------------------------------------------

  Widget buildGridViewList() {
    return GridView.builder(
        itemCount: getListCount(),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 2.0),
        itemBuilder: (context, index) {
          return CharacterItem(characterModel: getCharacterModel(index));
        });
  }

  Widget buildBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [buildGridViewList()],
      ),
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.yellow,
      ),
    );
  }

  Widget buildBlocWidget(String dropDownItemValue) {
    switch (dropDownItemValue) {
      case 'All Characters':
        return BlocBuilder<CharacterCubit, CharacterStates>(
            builder: (context, state) {
          if (state is CharactersGetSuccessState) {
            _charactersList = state.characters;
            print('Breaking Bad List : ' + _charactersList.length.toString());
            return buildBody();
          } else {
            return showLoadingIndicator();
          }
        });
      case 'Better Call Saul Characters':
        return BlocBuilder<BetterCallSaulCubit, GetBetterCallSaulStates>(
            builder: (context, state) {
          if (state is GetBetterCallSaulSuccessState) {
            _betterCallSaulCharactersList = state.characters;
            print('Better Call Saul List : ' +
                _betterCallSaulCharactersList.length.toString());
            return buildBody();
          } else {
            return showLoadingIndicator();
          }
        });
      default:
        return Container();
    }
  }

  Widget buildOfflineBuilder() {
    return Container(
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/server_error.svg',
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'No Internet Connection...',
            style: TextStyle(
              color: MyColors.yellow,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: _isSearching
                ? BackButton(
                    color: MyColors.grey,
                    onPressed: () {
                      _stopSearch();
                      Navigator.pop(context);
                    },
                  )
                : Container(),
            actions: buildAppBarActions(),
            backgroundColor: MyColors.yellow,
            title: _isSearching ? buildSearchField() : buildAppBarTitle(),
          ),
          body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return buildBlocWidget(_dropDownItemValue!);
              } else {
                return buildOfflineBuilder();
              }
            },
            child: showLoadingIndicator(),
          ),
        ));
  }
}
