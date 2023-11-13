// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poklon_bon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoklonBon _$PoklonBonFromJson(Map<String, dynamic> json) => PoklonBon(
      json['poklonBonId'] as int,
      json['pacijentId'] as int,
      json['ordinacijaId'] as int,
      json['kod'] as String?,
      (json['iznosPlacanja'] as num).toDouble(),
      json['imePrezimeKorisnikaKojiKoristi'] as String,
      json['placeno'] as bool,
      DateTime.parse(json['datumIstekaKartice'] as String),
      json['brojKartice'] as String,
      json['cvcCvvKod'] as String?,
      json['ordinacijaNaziv'] as String,
      json['pacijentIme'] as String,
      json['pacijentPrezime'] as String,
      json['iskoristeno'] as bool,
    );

Map<String, dynamic> _$PoklonBonToJson(PoklonBon instance) => <String, dynamic>{
      'poklonBonId': instance.poklonBonId,
      'pacijentId': instance.pacijentId,
      'ordinacijaId': instance.ordinacijaId,
      'opis': instance.kod,
      'iznosPlacanja': instance.iznosPlacanja,
      'imePrezimeKorisnikaKojiKoristi': instance.imePrezimeKorisnikaKojiKoristi,
      'placeno': instance.placeno,
      'datumIstekaKartice': instance.datumIstekaKartice.toIso8601String(),
      'brojKartice': instance.brojKartice,
      'cvcCvvKod': instance.cvcCvvKod,
      'ordinacijaNaziv': instance.ordinacijaNaziv,
      'pacijentIme': instance.pacijentIme,
      'pacijentPrezime': instance.pacijentPrezime,
      'iskoristeno': instance.iskoristeno,
    };
