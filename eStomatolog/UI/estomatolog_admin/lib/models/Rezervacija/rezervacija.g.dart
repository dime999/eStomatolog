// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacija _$RezervacijaFromJson(Map<String, dynamic> json) => Rezervacija(
      json['rezervacijaId'] as int,
      DateTime.parse(json['datum'] as String),
      json['doktorIme'] as String?,
      json['pacijentPrezime'] as String?,
      json['ordinacijaIme'] as String?,
      json['email'] as String?,
    );

Map<String, dynamic> _$RezervacijaToJson(Rezervacija instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'datum': instance.datum.toIso8601String(),
      'email': instance.email,
      'doktorIme': instance.doktorIme,
      'pacijentPrezime': instance.pacijentPrezime,
      'ordinacijaIme': instance.ordinacijaIme,
    };
