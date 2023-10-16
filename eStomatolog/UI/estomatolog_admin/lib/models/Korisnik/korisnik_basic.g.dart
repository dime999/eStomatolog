// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik_basic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikBasic _$KorisnikBasicFromJson(Map<String, dynamic> json) =>
    KorisnikBasic(
      json['korisnikId'] as int,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['email'] as String?,
    );

Map<String, dynamic> _$KorisnikBasicToJson(KorisnikBasic instance) =>
    <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
    };
