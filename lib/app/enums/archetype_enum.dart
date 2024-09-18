import 'package:flutter_translate/flutter_translate.dart';

enum ArchetypeEnum { all, crystron, destinyHero, sixSamurai }

extension ArchetypeEnumExtension on ArchetypeEnum {
  String get name {
    switch (this) {
      case ArchetypeEnum.all:
        return '';
      case ArchetypeEnum.crystron:
        return 'Crystron';
      case ArchetypeEnum.destinyHero:
        return 'Destiny Hero';
      case ArchetypeEnum.sixSamurai:
        return 'Six Samurai';
      default:
        return '';
    }
  }

  String get text {
    switch (this) {
      case ArchetypeEnum.all:
        return translate('all');
      case ArchetypeEnum.crystron:
        return translate('crystron');
      case ArchetypeEnum.destinyHero:
        return translate('destiny_hero');
      case ArchetypeEnum.sixSamurai:
        return translate('six_samurai');
      default:
        return '';
    }
  }
}
