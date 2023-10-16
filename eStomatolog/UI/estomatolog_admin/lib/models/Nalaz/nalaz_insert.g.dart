// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nalaz_insert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NalazInsert _$NalazInsertFromJson(Map<String, dynamic> json) => NalazInsert(
      json['doktorId'] as int,
      json['pacijentId'] as int,
      json['opis'] as String?,
      json['datum'] == null ? null : DateTime.parse(json['datum'] as String),
    );

Map<String, dynamic> _$NalazInsertToJson(NalazInsert instance) =>
    <String, dynamic>{
      'doktorId': instance.doktorId,
      'pacijentId': instance.pacijentId,
      'opis': instance.opis,
      'datum': instance.datum?.toIso8601String(),
    };
