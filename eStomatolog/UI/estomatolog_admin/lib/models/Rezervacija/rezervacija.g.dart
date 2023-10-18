// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacija _$RezervacijaFromJson(Map<String, dynamic> json) => Rezervacija(
      json['rezervacijaId'] as int,
      DateTime.parse(json['datum'] as String),
      json['pacijentId'] as int,
      json['terminId'] as int,
      json['doktorId'] as int,
      json['ordinacijaId'] as int,
      json['email'] as String?,
    );

Map<String, dynamic> _$RezervacijaToJson(Rezervacija instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'datum': instance.datum.toIso8601String(),
      'pacijentId': instance.pacijentId,
      'doktorId': instance.doktorId,
      'terminId': instance.terminId,
      'ordinacijaId': instance.ordinacijaId,
      'email': instance.email,
    };
