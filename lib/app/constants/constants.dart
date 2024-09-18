import 'dart:ui';

import 'package:fisatest/app/enums/archetype_enum.dart';

class ConstantsValues {
  ConstantsValues._();
  // static String apiKey = '/v7/cardinfo.php';
  static String apiKey = '/v7/cardinfo.php';

  static String language = 'en-En';
  static const designSize = Size(430, 932);
  static List<String> yesNoList = ['Si', 'No'];
  static List<ArchetypeEnum> filterList = [
    ArchetypeEnum.all,
    ArchetypeEnum.crystron,
    ArchetypeEnum.destinyHero,
    ArchetypeEnum.sixSamurai,
  ];
}
