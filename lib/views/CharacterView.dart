import 'package:flutter/material.dart';
import 'package:flutter_wars/models/Character.dart';
import 'package:flutter_wars/view_models/MainPageViewModel.dart';
import 'package:flutter_wars/views/styles/StarWarsStyles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class CharacterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainPageViewModel>(
      builder: (context, child, model) {
        if (model.noInternetConnection){
          return new Center(
            child: new Text('No Internet Conection'),
          );
        }

        if (model.isLoadingCharacters) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: model.characters == null ? 0 : model.characters.length,
          itemBuilder: (_, int index) {
            var character = model.characters[index];
            return CharacterListItem(character: character);
          },
        );
      },
    );
  }
}

class CharacterListItem extends StatelessWidget {
  final Character character;

  CharacterListItem({@required this.character});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            _affiliationSymbol(),
            color: Theme.of(context).primaryColorLight,
            size: 40.0,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          title: _title(),
          subtitle: _subTitle(),
        ),
        Divider(),
      ],
    );
  }

  Widget _title() {
    return Text(
      character?.name,
      style: TextStyle(
        color: StarWarsStyles.titleColor,
        fontWeight: FontWeight.bold,
        fontSize: StarWarsStyles.titleFontSize,
      ),
    );
  }

  Widget _subTitle() {
    return Row(
      children: <Widget>[
        Text(
          character?.birthYear,
          style: TextStyle(
            color: StarWarsStyles.subTitleColor,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 6.0),
          child: Icon(
            _genderSymbol(),
            color: StarWarsStyles.subTitleColor.withAlpha(200),
            size: StarWarsStyles.subTitleFontSize,
          ),
        ),
      ],
    );
  }

  IconData _affiliationSymbol() {
    switch (character.name) {
      case 'Luke Skywalker':
        return FontAwesomeIcons.jediOrder;
      case 'C-3PO':
        return FontAwesomeIcons.rebel;
      case 'R2-D2':
        return FontAwesomeIcons.rebel;
      case 'Darth Vader':
        return FontAwesomeIcons.empire;
      case 'Leia Organa':
        return FontAwesomeIcons.galacticRepublic;
      case 'Owen Lars':
        return Icons.face;
      case 'Beru Whitesun lars':
        return Icons.face;
      case 'R5-D4':
        return FontAwesomeIcons.rebel;
      case 'Biggs Darklighter':
        return FontAwesomeIcons.rebel;
      case 'Obi-Wan Kenobi':
        return FontAwesomeIcons.jediOrder;
      default:
        return null;
    }
  }

  IconData _genderSymbol() {
    switch (character.gender) {
      case 'male':
        return FontAwesomeIcons.mars;
      case 'female':
        return FontAwesomeIcons.venus;
      case 'n/a':
        return FontAwesomeIcons.robot;
      default:
        return null;
    }
  }
}