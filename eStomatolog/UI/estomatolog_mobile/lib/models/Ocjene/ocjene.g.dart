// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ocjene _$OcjeneFromJson(Map<String, dynamic> json) => Ocjene(
      json['doktorId'] as int,
      json['pacijentId'] as int,
      DateTime.parse(json['datum'] as String),
      json['ocjena'] as int,
    );

Map<String, dynamic> _$OcjeneToJson(Ocjene instance) => <String, dynamic>{
      'doktorId': instance.doktorId,
      'pacijentId': instance.pacijentId,
      'datum': instance.datum.toIso8601String(),
      'ocjena': instance.ocjena,
    };
