// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaModel _$MetaModelFromJson(Map<String, dynamic> json) => MetaModel(
      currentRows: json['current_rows'] as int?,
      totalRows: json['total_rows'] as int?,
      rowsRemaining: json['rows_remaining'] as int?,
      totalPages: json['total_pages'] as int?,
      pagesRemaining: json['pages_remaining'] as int?,
      previousPage: json['previous_page'] as String?,
      previousPageOffset: json['previous_page_offset'] as int?,
      nextPage: json['next_page'] as String?,
      nextPageOffset: json['next_page_offset'] as int?,
    );

Map<String, dynamic> _$MetaModelToJson(MetaModel instance) => <String, dynamic>{
      'current_rows': instance.currentRows,
      'total_rows': instance.totalRows,
      'rows_remaining': instance.rowsRemaining,
      'total_pages': instance.totalPages,
      'pages_remaining': instance.pagesRemaining,
      'previous_page': instance.previousPage,
      'previous_page_offset': instance.previousPageOffset,
      'next_page': instance.nextPage,
      'next_page_offset': instance.nextPageOffset,
    };
