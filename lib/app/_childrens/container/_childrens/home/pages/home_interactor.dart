import 'package:fisatest/app/_childrens/container/_childrens/home/models/cards_info_model.dart';
import 'package:fisatest/app/enums/archetype_enum.dart';
import 'package:flutter/material.dart';

abstract class HomeInteractor {
  void changeCurrentCard(CardInfoModel cardInfoModel);

  void reloeadData();
  void getMoreData();

  void changeCurrenFilter(ArchetypeEnum archetypeEnum);
  void changeBanList();
}
