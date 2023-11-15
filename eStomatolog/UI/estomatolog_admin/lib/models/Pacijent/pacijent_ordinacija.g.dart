// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacijent_ordinacija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PacijentOrdinacija _$PacijentOrdinacijaFromJson(Map<String, dynamic> json) =>
    PacijentOrdinacija(
      json['pacijentIme'] as String?,
      json['pacijentPrezime'] as String?,
      json['korisnikId'] as int,
      json['pacijentId'] as int,
    );

Map<String, dynamic> _$PacijentOrdinacijaToJson(PacijentOrdinacija instance) =>
    <String, dynamic>{
      'pacijentIme': instance.pacijentIme,
      'pacijentPrezime': instance.pacijentPrezime,
      'korisnikId': instance.korisnikId,
      'pacijentId': instance.pacijentId,
    };
