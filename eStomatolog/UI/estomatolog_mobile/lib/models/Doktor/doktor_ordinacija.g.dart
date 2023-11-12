// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doktor_ordinacija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoktorOrdinacija _$DoktorOrdinacijaFromJson(Map<String, dynamic> json) =>
    DoktorOrdinacija(
      json['doktorIme'] as String?,
      json['doktorPrezime'] as String?,
      json['korisnikId'] as int,
      json['doktorId'] as int,
      (json['ocjene'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$DoktorOrdinacijaToJson(DoktorOrdinacija instance) =>
    <String, dynamic>{
      'doktorIme': instance.doktorIme,
      'doktorPrezime': instance.doktorPrezime,
      'korisnikId': instance.korisnikId,
      'doktorId': instance.doktorId,
      'ocjene': instance.ocjene,
    };
