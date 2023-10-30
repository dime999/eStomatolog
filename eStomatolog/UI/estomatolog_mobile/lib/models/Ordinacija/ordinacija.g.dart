// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordinacija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ordinacija _$OrdinacijaFromJson(Map<String, dynamic> json) => Ordinacija(
      json['ordinacijaId'] as int,
      json['naziv'] as String,
      json['adresa'] as String,
      json['telefon'] as String,
      json['gradId'] as int,
    );

Map<String, dynamic> _$OrdinacijaToJson(Ordinacija instance) =>
    <String, dynamic>{
      'ordinacijaId': instance.ordinacijaId,
      'naziv': instance.naziv,
      'adresa': instance.adresa,
      'telefon': instance.telefon,
      'gradId': instance.gradId,
    };
