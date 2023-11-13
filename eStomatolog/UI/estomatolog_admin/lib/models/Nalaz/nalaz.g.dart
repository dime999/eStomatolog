// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nalaz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nalaz _$NalazFromJson(Map<String, dynamic> json) => Nalaz(
      json['doktorIme'] as String,
      json['doktorPrezime'] as String,
      json['opis'] as String,
      json['datum'] == null ? null : DateTime.parse(json['datum'] as String),
    );

Map<String, dynamic> _$NalazToJson(Nalaz instance) => <String, dynamic>{
      'doktorIme': instance.doktorIme,
      'doktorPrezime': instance.doktorPrezime,
      'opis': instance.opis,
      'datum': instance.datum?.toIso8601String(),
    };
