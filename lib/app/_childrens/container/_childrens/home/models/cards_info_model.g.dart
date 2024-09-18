// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cards_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardInfoModel _$CardInfoModelFromJson(Map<String, dynamic> json) =>
    CardInfoModel(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      frameType: json['frameType'] as String,
      description: json['desc'] as String,
      race: json['race'] as String,
      archetype: json['archetype'] as String?,
      ygoprodeckUrl: json['ygoprodeck_url'] as String,
      cardSets: (json['card_sets'] as List<dynamic>?)
          ?.map((e) => CardSetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cardImages: (json['card_images'] as List<dynamic>?)
          ?.map((e) => CardImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cardPrices: (json['card_prices'] as List<dynamic>?)
          ?.map((e) => CardPriceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      atk: json['atk'] as int?,
      def: json['def'] as int?,
      level: json['level'] as int?,
      attribute: json['attribute'] as String?,
    );

Map<String, dynamic> _$CardInfoModelToJson(CardInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'frameType': instance.frameType,
      'desc': instance.description,
      'race': instance.race,
      'archetype': instance.archetype,
      'ygoprodeck_url': instance.ygoprodeckUrl,
      'card_sets': instance.cardSets,
      'card_images': instance.cardImages,
      'card_prices': instance.cardPrices,
      'atk': instance.atk,
      'def': instance.def,
      'level': instance.level,
      'attribute': instance.attribute,
    };

CardSetModel _$CardSetModelFromJson(Map<String, dynamic> json) => CardSetModel(
      setName: json['set_name'] as String,
      setCode: json['set_code'] as String,
      setRarity: json['set_rarity'] as String,
      setRarityCode: json['set_rarity_code'] as String,
      setPrice: json['set_price'] as String,
    );

Map<String, dynamic> _$CardSetModelToJson(CardSetModel instance) =>
    <String, dynamic>{
      'set_name': instance.setName,
      'set_code': instance.setCode,
      'set_rarity': instance.setRarity,
      'set_rarity_code': instance.setRarityCode,
      'set_price': instance.setPrice,
    };

CardImageModel _$CardImageModelFromJson(Map<String, dynamic> json) =>
    CardImageModel(
      id: json['id'] as int,
      imageUrl: json['image_url'] as String,
      imageUrlSmall: json['image_url_small'] as String,
      imageUrlCropped: json['image_url_cropped'] as String,
    );

Map<String, dynamic> _$CardImageModelToJson(CardImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_url': instance.imageUrl,
      'image_url_small': instance.imageUrlSmall,
      'image_url_cropped': instance.imageUrlCropped,
    };

CardPriceModel _$CardPriceModelFromJson(Map<String, dynamic> json) =>
    CardPriceModel(
      cardmarketPrice: json['cardmarket_price'] as String,
      tcgplayerPrice: json['tcgplayer_price'] as String,
      ebayPrice: json['ebay_price'] as String,
      amazonPrice: json['amazon_price'] as String,
      coolstuffincPrice: json['coolstuffinc_price'] as String,
    );

Map<String, dynamic> _$CardPriceModelToJson(CardPriceModel instance) =>
    <String, dynamic>{
      'cardmarket_price': instance.cardmarketPrice,
      'tcgplayer_price': instance.tcgplayerPrice,
      'ebay_price': instance.ebayPrice,
      'amazon_price': instance.amazonPrice,
      'coolstuffinc_price': instance.coolstuffincPrice,
    };
