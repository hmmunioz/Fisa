import 'package:fisatest/app/_childrens/container/_childrens/home/models/cards_info_model.dart';
import 'package:flutter/widgets.dart';

abstract class ContainerAppInteractor {
  void logOut(BuildContext context);

  void changeCurrentCard(CardInfoModel cardInfoModel);
}
