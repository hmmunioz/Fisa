import 'package:json_annotation/json_annotation.dart';

part 'cards_info_model.g.dart';

@JsonSerializable()
class CardInfoModel {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'frameType')
  final String frameType;

  @JsonKey(name: 'desc')
  final String description;

  @JsonKey(name: 'race')
  final String race;

  @JsonKey(name: 'archetype')
  final String? archetype;

  @JsonKey(name: 'ygoprodeck_url')
  final String ygoprodeckUrl;

  @JsonKey(name: 'card_sets')
  final List<CardSetModel>? cardSets;

  @JsonKey(name: 'card_images')
  final List<CardImageModel>? cardImages;

  @JsonKey(name: 'card_prices')
  final List<CardPriceModel>? cardPrices;

  @JsonKey(name: 'atk')
  final int? atk;
  @JsonKey(name: 'def')
  final int? def;
  @JsonKey(name: 'level')
  final int? level;
  @JsonKey(name: 'attribute')
  final String? attribute;

  CardInfoModel({
    required this.id,
    required this.name,
    required this.type,
    required this.frameType,
    required this.description,
    required this.race,
    required this.archetype,
    required this.ygoprodeckUrl,
    required this.cardSets,
    required this.cardImages,
    required this.cardPrices,
    required this.atk,
    required this.def,
    required this.level,
    required this.attribute,
  });

  factory CardInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CardInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardInfoModelToJson(this);
}

@JsonSerializable()
class CardSetModel {
  @JsonKey(name: 'set_name')
  final String setName;

  @JsonKey(name: 'set_code')
  final String setCode;

  @JsonKey(name: 'set_rarity')
  final String setRarity;

  @JsonKey(name: 'set_rarity_code')
  final String setRarityCode;

  @JsonKey(name: 'set_price')
  final String setPrice;

  CardSetModel({
    required this.setName,
    required this.setCode,
    required this.setRarity,
    required this.setRarityCode,
    required this.setPrice,
  });

  factory CardSetModel.fromJson(Map<String, dynamic> json) =>
      _$CardSetModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardSetModelToJson(this);
}

@JsonSerializable()
class CardImageModel {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'image_url')
  final String imageUrl;

  @JsonKey(name: 'image_url_small')
  final String imageUrlSmall;

  @JsonKey(name: 'image_url_cropped')
  final String imageUrlCropped;

  CardImageModel({
    required this.id,
    required this.imageUrl,
    required this.imageUrlSmall,
    required this.imageUrlCropped,
  });

  factory CardImageModel.fromJson(Map<String, dynamic> json) =>
      _$CardImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardImageModelToJson(this);
}

@JsonSerializable()
class CardPriceModel {
  @JsonKey(name: 'cardmarket_price')
  final String cardmarketPrice;

  @JsonKey(name: 'tcgplayer_price')
  final String tcgplayerPrice;

  @JsonKey(name: 'ebay_price')
  final String ebayPrice;

  @JsonKey(name: 'amazon_price')
  final String amazonPrice;

  @JsonKey(name: 'coolstuffinc_price')
  final String coolstuffincPrice;

  CardPriceModel({
    required this.cardmarketPrice,
    required this.tcgplayerPrice,
    required this.ebayPrice,
    required this.amazonPrice,
    required this.coolstuffincPrice,
  });

  factory CardPriceModel.fromJson(Map<String, dynamic> json) =>
      _$CardPriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardPriceModelToJson(this);
}
