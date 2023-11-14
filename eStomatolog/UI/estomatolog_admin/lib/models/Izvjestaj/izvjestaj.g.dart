// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'izvjestaj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Izvjestaj _$IzvjestajFromJson(Map<String, dynamic> json) => Izvjestaj(
      json['ukopnoKorisnika'] as int,
      json['brojDoktora'] as int,
      json['brojPacijenta'] as int,
      json['brojRezervacija'] as int,
      json['brojAktinihRezervacija'] as int,
      json['brojNeaktivnihRezervacija'] as int,
      json['brojNalaza'] as int,
      json['brojPoklonBonova'] as int,
    );

Map<String, dynamic> _$IzvjestajToJson(Izvjestaj instance) => <String, dynamic>{
      'ukopnoKorisnika': instance.ukopnoKorisnika,
      'brojDoktora': instance.brojDoktora,
      'brojPacijenta': instance.brojPacijenta,
      'brojRezervacija': instance.brojRezervacija,
      'brojAktinihRezervacija': instance.brojAktinihRezervacija,
      'brojNeaktivnihRezervacija': instance.brojNeaktivnihRezervacija,
      'brojNalaza': instance.brojNalaza,
      'brojPoklonBonova': instance.brojPoklonBonova,
    };
