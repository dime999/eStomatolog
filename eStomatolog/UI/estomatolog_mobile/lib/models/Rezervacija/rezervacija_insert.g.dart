// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_insert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijaInsert _$RezervacijaInsertFromJson(Map<String, dynamic> json) =>
    RezervacijaInsert(
      DateTime.parse(json['datum'] as String),
      json['email'] as String?,
      json['pacijentId'] as int,
      json['ordinacijaId'] as int,
      json['doktorId'] as int,
      json['terminId'] as int,
    );

Map<String, dynamic> _$RezervacijaInsertToJson(RezervacijaInsert instance) =>
    <String, dynamic>{
      'datum': instance.datum.toIso8601String(),
      'email': instance.email,
      'pacijentId': instance.pacijentId,
      'ordinacijaId': instance.ordinacijaId,
      'doktorId': instance.doktorId,
      'terminId': instance.terminId,
    };
