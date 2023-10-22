// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ocjene _$OcjeneFromJson(Map<String, dynamic> json) => Ocjene(
      json['id'] as int,
      json['pacijentId'] as int,
      json['doktorId'] as int,
      DateTime.parse(json['datum'] as String),
      json['ocjena'] as int,
      json['doktorIme'] as String,
      json['doktorPrezime'] as String,
      json['pacijentIme'] as String,
      json['pacijentPrezime'] as String,
    );

Map<String, dynamic> _$OcjeneToJson(Ocjene instance) => <String, dynamic>{
      'id': instance.id,
      'pacijentId': instance.pacijentId,
      'doktorId': instance.doktorId,
      'datum': instance.datum.toIso8601String(),
      'ocjena': instance.ocjena,
      'pacijentIme': instance.pacijentIme,
      'pacijentPrezime': instance.pacijentPrezime,
      'doktorIme': instance.doktorIme,
      'doktorPrezime': instance.doktorPrezime,
    };
