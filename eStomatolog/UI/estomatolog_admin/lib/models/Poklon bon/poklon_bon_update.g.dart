// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poklon_bon_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoklonBonUpdate _$PoklonBonUpdateFromJson(Map<String, dynamic> json) =>
    PoklonBonUpdate(
      json['pacijentId'] as int,
      json['ordinacijaId'] as int,
      json['kod'] as String?,
      (json['iznosPlacanja'] as num).toDouble(),
      json['imePrezimeKorisnikaKojiKoristi'] as String,
      json['placeno'] as bool,
      DateTime.parse(json['datumIstekaKartice'] as String),
      json['brojKartice'] as String,
      json['cvcCvvKod'] as String?,
      json['iskoristeno'] as bool,
    );

Map<String, dynamic> _$PoklonBonUpdateToJson(PoklonBonUpdate instance) =>
    <String, dynamic>{
      'pacijentId': instance.pacijentId,
      'ordinacijaId': instance.ordinacijaId,
      'kod': instance.kod,
      'iznosPlacanja': instance.iznosPlacanja,
      'imePrezimeKorisnikaKojiKoristi': instance.imePrezimeKorisnikaKojiKoristi,
      'placeno': instance.placeno,
      'datumIstekaKartice': instance.datumIstekaKartice.toIso8601String(),
      'brojKartice': instance.brojKartice,
      'cvcCvvKod': instance.cvcCvvKod,
      'iskoristeno': instance.iskoristeno,
    };
