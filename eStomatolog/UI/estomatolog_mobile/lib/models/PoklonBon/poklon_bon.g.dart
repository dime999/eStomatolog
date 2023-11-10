// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poklon_bon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoklonBon _$PoklonBonFromJson(Map<String, dynamic> json) => PoklonBon(
      json['kod'] as String,
      (json['iznosPlacanja'] as num).toDouble(),
      json['imePrezimeKorisnikaKojiKoristi'] as String,
      json['placeno'] as bool,
      json['iskoristeno'] as bool,
    );

Map<String, dynamic> _$PoklonBonToJson(PoklonBon instance) => <String, dynamic>{
      'opis': instance.kod,
      'iznosPlacanja': instance.iznosPlacanja,
      'imePrezimeKorisnikaKojiKoristi': instance.imePrezimeKorisnikaKojiKoristi,
      'placeno': instance.placeno,
      'iskoristeno': instance.iskoristeno,
    };
