// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik_kartica_insert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikKarticaInsert _$KorisnikKarticaInsertFromJson(
        Map<String, dynamic> json) =>
    KorisnikKarticaInsert(
      json['korisnikId'] as int?,
      json['brojKartice'] as String?,
      json['vrstaKartica'] as String?,
      json['datumIsteka'] as String?,
      json['cvv'] as String?,
    );

Map<String, dynamic> _$KorisnikKarticaInsertToJson(
        KorisnikKarticaInsert instance) =>
    <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'brojKartice': instance.brojKartice,
      'vrstaKartica': instance.vrstaKartica,
      'datumIsteka': instance.datumIsteka,
      'cvv': instance.cvv,
    };
