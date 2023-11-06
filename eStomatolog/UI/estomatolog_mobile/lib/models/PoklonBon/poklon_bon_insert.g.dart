// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poklon_bon_insert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoklonBonInsert _$PoklonBonInsertFromJson(Map<String, dynamic> json) =>
    PoklonBonInsert(
      json['kod'] as String?,
      json['iznosPlacanja'] as int?,
      json['pacijentId'] as int,
      json['ordinacijaId'] as int,
      json['imePrezimeKorisnikaKojiKoristi'] as String?,
      json['placeno'] as bool,
      json['brojKartice'] as String?,
      json['datumIstekaKartice'] == null
          ? null
          : DateTime.parse(json['datumIstekaKartice'] as String),
      json['cvcCvvKod'] as String?,
      json['iskoristeno'] as bool,
    );

Map<String, dynamic> _$PoklonBonInsertToJson(PoklonBonInsert instance) =>
    <String, dynamic>{
      'kod': instance.kod,
      'iznosPlacanja': instance.iznosPlacanja,
      'pacijentId': instance.pacijentId,
      'ordinacijaId': instance.ordinacijaId,
      'imePrezimeKorisnikaKojiKoristi': instance.imePrezimeKorisnikaKojiKoristi,
      'placeno': instance.placeno,
      'brojKartice': instance.brojKartice,
      'datumIstekaKartice': instance.datumIstekaKartice?.toIso8601String(),
      'cvcCvvKod': instance.cvcCvvKod,
      'iskoristeno': instance.iskoristeno,
    };
