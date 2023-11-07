// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik_kartica.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikKartica _$KorisnikKarticaFromJson(Map<String, dynamic> json) =>
    KorisnikKartica(
      json['id'] as int,
      json['korisnikId'] as int?,
      json['brojKartice'] as String,
      json['vrstaKartica'] as String,
      json['datumIsteka'] as String,
      json['cvv'] as String?,
    );

Map<String, dynamic> _$KorisnikKarticaToJson(KorisnikKartica instance) =>
    <String, dynamic>{
      'id': instance.id,
      'korisnikId': instance.korisnikId,
      'brojKartice': instance.brojKartice,
      'vrstaKartica': instance.vrstaKartica,
      'datumIsteka': instance.datumIsteka,
      'cvv': instance.cvv,
    };
